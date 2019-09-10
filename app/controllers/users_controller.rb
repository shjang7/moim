# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  before_action :find_user, only: %i[show]

  def show
    if @user
      @post = @user.writing_posts.build
      @posts = @user.writing_posts.paginate(page: params[:page])
    else
      flash[:alert] = I18n.t('customs.users.show.failure')
      redirect_to root_path
    end
    @comment = current_user.comments.build
  end

  def index
    @friends = {}
    if params[:type] == 'pending_friends'
      @friends[:pending_friends] = current_user.pending_friends.paginate(page: params[:page])
    elsif params[:type] == 'current_friends'
      @user = User.find_by_id(params[:user_id])
      @friends[:current_friends] = @user.friends.paginate(page: params[:page])
    else # default type 'find_friends'
      @friends[:friend_requests] = current_user.friend_requests.paginate(page: params[:page], per_page: 2)
      @friends[:find_friends] = current_user.recommended_friends.paginate(page: params[:page])
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
