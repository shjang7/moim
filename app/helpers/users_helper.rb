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
end
