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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  def pending_friends
    User
      .where(id: any_friendships.where(confirmed: false).select { |f| f.user_id == id }.pluck(:friend_id))
      .order_created
  end

  def friend_requests
    User
      .where(id: any_friendships.where(confirmed: false).select { |f| f.friend_id == id }.pluck(:user_id))
      .order_created
  end

  def friends
    User
      .where(id: any_friendships.where(confirmed: true).map { |f| f.the_other_person(self) })
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

  def feed
    Post
      .where(author_id: id)
      .or(Post
            .where(author_id: any_friendships.where(confirmed: true).map do |f|
              f.the_other_person(self)
            end))
  end

  def confirm_friend(friend)
    friendship = any_friendships.where(confirmed: false).find { |friendship| friendship.friend == friend }
    friendship.confirmed = true
    friendship
  end

  def friend?(user)
    friends.include?(user)
  end

  def unknown_people
    User.where.not(id: any_friendships.map { |f| f.the_other_person(self) })
        .where.not(id: id)
  end
end
