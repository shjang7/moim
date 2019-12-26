class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(friend_id: friend.id)
    if @friendship.save
      flash[:notice] = I18n.t('customs.friendships.create')
    else
      flash[:alert] = @friendship.errors.full_messages[0]
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    user = User.find(params[:user_id])
    @friendship = user.confirm_friend(current_user)
    if @friendship.update(user_id: user.id)
      flash[:notice] = I18n.t('customs.friendships.update')
    else
      flash[:alert] = @friendship.errors.full_messages[0]
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find_by_id(params[:id])
    if @friendship.destroy
      flash[:notice] = I18n.t('customs.resources.destroy.success', resource_name)
      redirect_to root_path if params[:type] == 'cancel_request'
      redirect_back(fallback_location: root_path) unless params[:type] == 'cancel_request'
    else
      flash[:alert] = I18n.t('customs.resources.destroy.failure', resource_name)
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def resource_name
    { resource: 'Friendship' }
  end
end
