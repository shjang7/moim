# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
      @post = @user.writing_posts.build
      @posts = Post.paginate(page: params[:page]) # for now, future : feed list
      # @feed_items = current_user.feed.paginate(page: params[:page])
    end
    # else : we don't need any.
  end

  def feedback; end
end
