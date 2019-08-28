# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :find_user, only: %i[show]

  def show
    if @user
      @post = @user.writing_posts.build
      @posts = @user.writing_posts.paginate(page: params[:page])
    else
      flash[:alert] = 'Access to wrong user'
      redirect_to root_path
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end
end