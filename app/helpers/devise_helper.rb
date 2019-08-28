# frozen_string_literal: true

module DeviseHelper
  def current_user?(user)
    current_user == user
  end
end
