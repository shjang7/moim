# frozen_string_literal: true

class User < ApplicationRecord
  has_many :writing_posts, class_name: 'Post',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_like_brokers, dependent: :destroy
  has_many :liked_posts, through: :post_like_brokers, source: :post
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id'
  # has_many :friends, through: :friendships, source: :friend
  scope :all_except, ->(user) { where.not(id: user) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  def friends
    friends_group = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_group += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_group.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  # future : after connection friendship
  # def feed
  # end
end
