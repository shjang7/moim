class PostLikeBrokersController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    post = Post.find(params[:id])
    post.liker_add(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = PostLikeBroker.find(params[:id]).post
    post.liker_remove(current_user)
    redirect_back(fallback_location: root_path)
  end
end
