# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :find_post, only: %i[destroy]
  before_action :correct_user, only: %i[destroy]

  def create
    @post = current_user.writing_posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post created!'
    else
      flash[:alert] = 'It is blank'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted'
    else
      flash[:alert] = 'Post cannot be deleted, send us feedback'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_post
    @post = Post.find_by_id(params[:id])
  end

  def correct_user
    return if current_user.writing_posts.find_by_id(params[:id])

    flash[:alert] = 'Please access with right user'
    redirect_back(fallback_location: root_path)
  end
end
