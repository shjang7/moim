# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = @user.writing_posts.build
    @posts = @user.writing_posts.all
  end
end
