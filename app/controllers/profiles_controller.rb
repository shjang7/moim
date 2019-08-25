# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:alert] = 'Access to wrong user'
      redirect_to root_url
      return
    end
    @post = @user.writing_posts.build
    @posts = @user.writing_posts.paginate(page: params[:page])
  end
end
