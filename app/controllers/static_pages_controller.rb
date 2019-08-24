# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      # for future implement
      @post = current_user.posts.build
      # @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def feedback; end
end
