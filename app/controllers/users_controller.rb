# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = @user.posts.build
    @posts = @user.posts.all
  end
end
