# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:jen) { create(:user, name: 'Jen Barber') }
  let(:roy) { create(:user, name: 'Roy Trenneman') }
  let(:friendship_confirmed) do
    Friendship.new(user_id: jen.id,
                   friend_id: roy.id,
                   confirmed: true)
  end
  let(:friendship_unconfirmed) do
    Friendship.new(user_id: jen.id,
                   friend_id: roy.id)
  end
  let(:rev_friendship_unconfirmed) do
    Friendship.new(user_id: roy.id,
                   friend_id: jen.id)
  end

  context 'with valid attributes' do
    it 'is valid' do
      expect(friendship_unconfirmed).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should require a user_id' do
      friendship_unconfirmed.user_id = nil
      expect(friendship_unconfirmed).to_not be_valid
    end

    it 'should require a friend_id' do
      friendship_unconfirmed.friend_id = nil
      expect(friendship_unconfirmed).to_not be_valid
    end
  end

  context '#no_pending_status for create' do
    it 'should be unique for pending status friendship' do
      friendship_unconfirmed.save!
      expect(rev_friendship_unconfirmed).to_not be_valid
    end
  end

  context '#no_friend_status for create' do
    it 'should be unique for confirmed status friendship' do
      friendship_confirmed.save!
      expect(rev_friendship_unconfirmed).to_not be_valid
    end
  end
end
