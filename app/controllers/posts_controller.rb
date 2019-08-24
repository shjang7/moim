# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
    @posts = Post.all
    # @my_posts = Post.find(params[:user_id])
  end

  def show # for debugging
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to root_url
    else
      @feed_items = []
      render static_pages_home_url
      # render 'static_pages/home'
    end
  end
  # show, new, edit, create, update, destroy

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
