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
  def mutual_friends_info(user, class_type = {})
    case current_user.mutual_friends_with(user).count
    when 0
      nil
    when 1
      content_tag(:div, "#{current_user.mutual_friends_with(user).first.name} is a mutual friend",
                  class_type)
    else
      content_tag(:div,
                  "#{current_user.mutual_friends_with(user).first.name} and
                  #{current_user.mutual_friends_with(user).count - 1} other mutual friends",
                  class_type)
    end
  end
end
