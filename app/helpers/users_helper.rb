# frozen_string_literal: true

module UsersHelper
  # Returns the profile image for the given user.
  def profile_img_for(user)
    if user.profile_pic.nil?
      profile_url = "cat-1.jpg"
    else
      profile_url = user.profile_pic.sub("_normal", "")
    end
    image_tag(profile_url, alt: user.name, class: "profile-pic")
  end
end
