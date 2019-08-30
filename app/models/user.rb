# frozen_string_literal: true

class User < ApplicationRecord
  has_many :writing_posts, class_name: 'Post',
                           foreign_key: 'author_id',
                           dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :like_posts, through:   :post_likes, source: :post
  scope :all_except, ->(user) { where.not(id: user) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  def like_post_add(post)
    like_posts << post
  end

  def like_post_remove(post)
    like_posts.delete post
  end

  def like_post?(post)
    like_posts.include? post
  end
  # future : after connection friendship
  # def feed
  # end
end
