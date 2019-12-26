module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = I18n.t('customs.app.name')
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def users_page_title(type, user)
    case type
    when :new_friends
      I18n.t('customs.titles.find_friends')
    when :pending_friends
      I18n.t("customs.titles.#{type}")
    else
      I18n.t("customs.titles.#{type}", name: user.name.possessive)
    end
  end

  # Returns the full path on a per-page basis
  def users_path_with_user_id_and_page(user, index)
    users_path(anchor: "user-#{user.id}", page: index / 2 + 1)
  end

  # Returns the full path on a user basis
  def users_path_for_current_friends_with_user_id(user)
    users_path(type: 'current_friends', user_id: user.id)
  end
end
