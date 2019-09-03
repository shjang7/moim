# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id],
                                                 confirmed: true)
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
