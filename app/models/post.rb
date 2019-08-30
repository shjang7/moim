# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author,     class_name: 'User'
  has_many   :post_likes, dependent: :destroy
  has_many   :likers,     through: :post_likes, source: :user
  default_scope -> { order(created_at: :desc) }
  validates   :content,   presence: true
  validates   :author_id, presence: true
end
