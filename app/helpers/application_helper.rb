# frozen_string_literal: true

module ApplicationHelper
  # Returns the full title on a per-page basis
  $app_name = 'Moim'

  def full_title(page_title = '')
    base_title = $app_name
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
