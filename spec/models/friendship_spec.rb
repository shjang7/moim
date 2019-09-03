# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:jen) { create(:user, name: 'Jen Barber') }
  let(:roy) { create(:user, name: 'Roy Trenneman') }
  let(:friendship) do
    Friendship.new(user_id: jen.id,
                   friend_id: roy.id,
                   confirmed: true)
  end

  context 'with valid attributes' do
    it 'is valid' do
      expect(friendship).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should require a user_id' do
      friendship.user_id = nil
      expect(friendship).to_not be_valid
    end

    it 'should require a friend_id' do
      friendship.friend_id = nil
      expect(friendship).to_not be_valid
    end
  end
end
