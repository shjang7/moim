# frozen_string_literal: true

class User < ApplicationRecord
  has_many :writing_posts, class_name: 'Post',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_like_brokers, dependent: :destroy
  has_many :liked_posts, through: :post_like_brokers, source: :post
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id',
                                 dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  def friends
    friend_ids = "SELECT friend_id FROM friendships
                      WHERE user_id = :user_id AND confirmed = true
                  UNION ALL
                  SELECT user_id FROM friendships
                      WHERE friend_id = :user_id AND confirmed = true
                  "
    User.where("id IN (#{friend_ids})",
               friend_ids: friend_ids, user_id: id)
  end

  def recommended_friends
    related_ids = "SELECT id FROM users
                       WHERE id = :user_id
                   UNION ALL
                   SELECT friend_id FROM friendships
                       WHERE user_id = :user_id
                   UNION ALL
                   SELECT user_id FROM friendships
                       WHERE friend_id = :user_id
                   "
    User.where.not("id IN (#{related_ids})", related_ids: related_ids, user_id: id)
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friend_ids = "SELECT friend_id FROM friendships
                     WHERE user_id = :user_id AND confirmed = false"
    User.where("id IN (#{friend_ids})",
               friend_ids: friend_ids, user_id: id)
  end

  # Users who have requested to be friends
  def friend_requests
    friend_ids = "SELECT user_id FROM friendships
                     WHERE friend_id = :user_id AND confirmed = false"
    User.where("id IN (#{friend_ids})",
               friend_ids: friend_ids, user_id: id)
  end

  def confirm_friend(friend)
    friendship = friendships.find { |friendship| friendship.friend == friend }
    friendship.confirmed = true
    friendship
  end

  def friend?(user)
    friends.include?(user)
  end

  def feed
    feed_ids = "SELECT id FROM users
                     WHERE id = :user_id
                UNION ALL
                SELECT friend_id FROM friendships
                    WHERE user_id = :user_id AND confirmed = true
                UNION ALL
                SELECT user_id FROM friendships
                    WHERE friend_id = :user_id AND confirmed = true
                "
    Post.where("author_id IN (#{feed_ids})",
               feed_ids: feed_ids, user_id: id)
  end
end
