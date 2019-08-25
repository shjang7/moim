# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @post = current_user.writing_posts.build
      @posts = Post.paginate(page: params[:page]) # for temp. later implement for feed list
      # @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def feedback; end
end
