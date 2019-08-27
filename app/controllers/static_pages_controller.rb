# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?
    
    @user = current_user
    @post = @user.writing_posts.build
    @posts = Post.paginate(page: params[:page])
    # future : feed list
    # @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def feedback; end
end
