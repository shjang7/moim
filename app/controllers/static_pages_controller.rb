# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if @user = current_user
      @post = @user.writing_posts.build
      @posts = Post.paginate(page: params[:page])
      # future : feed list
      # @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def feedback; end
end
