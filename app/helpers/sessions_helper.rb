module SessionsHelper
  def current_user?(user)
    current_user == user
  end
end
