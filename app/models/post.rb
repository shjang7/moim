# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author,     class_name: 'User'
  has_many   :post_like_brokers, dependent: :destroy
  has_many   :likers,     through: :post_like_brokers, source: :user
  default_scope -> { order(created_at: :desc) }
  validates   :content,   presence: true
  validates   :author_id, presence: true

  def liker_add(user)
    likers << user
  end

  def liker_remove(user)
    likers.delete user
  end

  def liker?(user)
    likers.include? user
  end
end
