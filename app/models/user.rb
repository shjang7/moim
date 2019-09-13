# frozen_string_literal: true

class User < ApplicationRecord
  scope :order_created, -> { order(created_at: :desc) }
  has_many :writing_posts, class_name: 'Post',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_like_brokers, dependent: :destroy
  has_many :liked_posts, through: :post_like_brokers, source: :post
  has_many :friendships, dependent: :destroy
  has_many :any_friendships, lambda { |user|
    unscope(:where).where('user_id = :id OR friend_id = :id', id: user.id)
  }, class_name: :Friendship, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_person_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.profile_pic = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def pending_friends
    User
      .where(id: any_friendships.where(confirmed: false).where(user_id: id).pluck(:friend_id))
      .order_created
  end

  def friend_requests
    User
      .where(id: any_friendships.where(confirmed: false).where(friend_id: id).pluck(:user_id))
      .order_created
  end

  def friends
    User
      .where(id: any_friendships.where(confirmed: true).map do |friendship|
                   friendship.the_other_person(self)
                 end)
      .order_created
  end

  def mutual_friends_with(one)
    return User.none if self == one

    friends.where(id: one.friends.pluck(:id))
  end

  def recommended_friends
    User
      .where(id: unknown_people.select do |person|
                   mutual_friends_with(person).any?
                 end.map(&:id))
  end

  def new_friends
    User
      .where(id: unknown_people.select do |person|
                   mutual_friends_with(person).none?
                 end.map(&:id))
  end

  def feed
    Post
      .where(author_id: id)
      .or(Post
            .where(author_id: any_friendships.where(confirmed: true).map do |f|
              f.the_other_person(self)
            end))
  end

  def confirm_friend(friend)
    friendship = any_friendships.where(confirmed: false).find_by(friend: friend)
    friendship.confirmed = true
    friendship
  end

  def friend?(user)
    friends.include?(user)
  end

  private

  def unknown_people
    User.where.not(id: any_friendships.map do |friendship|
                         friendship.the_other_person(self)
                       end)
        .where.not(id: id)
  end
end
