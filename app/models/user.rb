# frozen_string_literal: true

class User < ApplicationRecord
  has_many :writing_posts, class_name: 'Post',
                           foreign_key: 'author_id',
                           dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  # def feed
  # after connection friendship
  # end

  def writing_posts?(post)
    writing_posts.include? post
  end
end
