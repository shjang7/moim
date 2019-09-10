# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true
  validate :no_pending_status, on: :create
  validate :no_friend_status, on: %i[create update]

  def the_other_person(user)
    user_id == user.id ? friend_id : user_id
  end

  private

  def no_pending_status
    if Friendship.where(user_id: friend_id, friend_id: user_id, confirmed: false).exists? ||
       Friendship.where(user_id: user_id, friend_id: friend_id, confirmed: false).exists?
      errors.add(:user_id, 'Pending status, check the inbox')
    end
  end

  def no_friend_status
    if Friendship.where(user_id: friend_id, friend_id: user_id, confirmed: true).exists? ||
       Friendship.where(user_id: user_id, friend_id: friend_id, confirmed: true).exists?
      errors.add(:user_id, 'Already friends!')
    end
  end
end
