# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :correct_user, only: %i[destroy]

  def create
    @post = current_user.writing_posts.build(post_params)
    return unless @post.save

    flash[:notice] = 'Post created!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post deleted'
    redirect_back(fallback_location: root_path)
  end
  # edit, update, destroy

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    match_post = current_user.writing_posts.find_by_id(params[:id])
    return if match_post

    flash[:alert] = 'Wrong access'
    redirect_back(fallback_location: root_path)
  end
end
