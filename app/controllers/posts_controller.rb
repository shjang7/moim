# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    @post = current_user.writing_posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to root_url
    else
      @feed_items = []
      render static_pages_home_url
    end
  end

  def destroy
  end
  # edit, update, destroy

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
