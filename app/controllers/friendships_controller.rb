# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    friend = User.find(params[:friend_id])
    if params[:type] == "accept"
      @friendship = current_user.confirm_friend(friend)
      @friendship.confirmed = true
    elsif params[:type] == "request"
      @friendship = current_user.friendships.build(friend_id: friend.id,
                                                   confirmed: false)
    end
    if @friendship.save
      flash[:notice] = I18n.t('customs.resources.create', resource_name)
    else
      flash[:alert] = @friendship.errors.full_messages[0]
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find_by_id(params[:id])
    if @friendship.destroy
      flash[:notice] = I18n.t('customs.resources.destroy.success', resource_name)
    else
      flash[:alert] = I18n.t('customs.resources.destroy.failure', resource_name)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def resource_name
    { resource: 'Friendship' }
  end
end
