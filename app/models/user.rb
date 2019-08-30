# frozen_string_literal: true

class User < ApplicationRecord
  has_many :writing_posts, class_name: 'Post',
                           foreign_key: 'author_id',
                           dependent: :destroy
  scope :all_except, ->(user) { where.not(id: user) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_person_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  # future : after connection friendship
  # def feed
  # end
end
