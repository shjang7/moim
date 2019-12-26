require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#profile_img_for' do
    let(:jen) { create(:user) }

    it 'returns image tag' do
      method = profile_img_for(jen)
      expect(method).to have_css 'img'
    end
  end

  describe '#mutual_friends_info' do
    let(:jen) { create(:user, name: 'Jen Barber') }
    let(:roy) { create(:user, name: 'Roy Trenneman') }
    let(:moris) { create(:user, name: 'Moris Mos') }
    let(:denholm) { create(:user, name: 'Denholm Reynholm') }
    let(:create_friendship) do
      lambda do |user, friend, confirmed|
        user.friendships.create!(friend_id: friend.id, confirmed: confirmed)
      end
    end
    let(:one_mutual_friend_message) do
      ->(user) { "#{user.name} is a mutual friend" }
    end
    let(:more_than_one_mutual_friend_message) do
      ->(user, count) { "#{user.name} and #{count} other mutual friends" }
    end
    let(:one_mutual_friendship_building) do
      create_friendship[jen, roy, true]
      create_friendship[roy, moris, true]
    end
    let(:two_mutual_friendship_building) do
      create_friendship[roy, jen, true]
      create_friendship[roy, moris, true]
      create_friendship[denholm, jen, true]
      create_friendship[denholm, moris, true]
    end
    let(:recent_co_friend) do
      double(friend: denholm, count: 1)
    end

    it 'returns null when no mutual friends' do
      expect(mutual_friends_info(jen, roy)).to be nil
    end

    it 'returns one mutual friends information' do
      one_mutual_friendship_building
      expect(mutual_friends_info(jen, moris)).to have_content one_mutual_friend_message[roy]
    end

    it 'returns more than one mutual friends information' do
      two_mutual_friendship_building
      expect(mutual_friends_info(jen, moris)).to have_content
      more_than_one_mutual_friend_message
      [recent_co_friend.friend, recent_co_friend.count]
    end
  end
end
