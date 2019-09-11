# frozen_string_literal: true

module UsersHelper
  # Returns the profile image for the given user.
  def profile_img_for(user, size = 80)
    profile_url = if user.profile_pic.nil?
                    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
                    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
                  else
                    user.profile_pic.sub('_normal', '')
                  end
    image_tag(profile_url, alt: user.name, class: 'profile-pic')
  end

  # Returns the mutual friends information for the given user.
  def mutual_friends_info(user_one, user_two, class_type = {})
    case user_one.mutual_friends_with(user_two).count
    when 0
      nil
    when 1
      content_tag(:div, "#{user_one.mutual_friends_with(user_two).first.name} is a mutual friend",
                  class_type)
    else
      content_tag(:div,
                  "#{user_one.mutual_friends_with(user_two).first.name} and
                  #{user_one.mutual_friends_with(user_two).count - 1} other mutual friends",
                  class_type)
    end
  end
end
