# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  before_action :find_user, only: %i[show]

  def show
    if @user
      @post = @user.writing_posts.build
      @posts = @user.writing_posts.paginate(page: params[:page])
      @comment = current_user.comments.build
    else
      flash[:alert] = I18n.t('customs.users.show.failure')
      redirect_to root_path
    end
  end

  def index
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
    @find_friends = User.all_except(current_user.find_friends).paginate(page: params[:page])
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
