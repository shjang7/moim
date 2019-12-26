class Users::SessionsController < Devise::SessionsController
  after_action :notify_for_friend_requests, only: [:create]

  def notify_for_friend_requests
    return unless flash.notice && current_user.friend_requests.any?

    flash.notice += ' Friend request : ' + current_user.friend_requests.count.to_s
  end
end
