# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with valid attributes' do
    it 'is valid with correct informations' do
      jen = User.new(
        first_name: 'Jen',
        last_name: 'Barber',
        email: 'jen@example.com',
        password: 'foobar'
      )
      expect(jen).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'returns a user\'s full name as a string' do
      user = build(:user)
      full_name = "#{user.first_name} #{user.last_name}"
      expect(user.name). to eq full_name
    end
  end

  context 'with invalid attributes for blank' do
    it 'is invalid without first name' do
      user = build(:user, first_name: '')
      expect(user).to_not be_valid
    end

    it 'is invalid without last name' do
      user = build(:user, last_name: '')
      expect(user).to_not be_valid
    end

    it 'is invalid without password' do
      user = build(:user, password: '')
      expect(user).to_not be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: '')
      expect(user).to_not be_valid
    end

    it 'is invalid without password' do
      user = build(:user, password: '')
      expect(user).to_not be_valid
    end
  end

  context 'with invalid attributes for wrong info' do
    it 'is invalid with long size first name' do
      user = build(:user, first_name: 'a' * 31)
      expect(user).to_not be_valid
    end

    it 'is invalid with long size last name' do
      user = build(:user, last_name: 'a' * 31)
      expect(user).to_not be_valid
    end

    it 'is invalid with duplicate email' do
      mos = create(:user)
      user = build(:user, email: mos.email)
      expect(user).to_not be_valid
    end

    it 'is invalid with short password' do
      user = build(:user, password: 'a' * 5)
      expect(user).to_not be_valid
    end

    it 'is invalid with long password' do
      user = build(:user, last_name: 'a' * 129)
      expect(user).to_not be_valid
    end
  end

  context 'with associated writing posts' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:lorem) { 'Lorem ipsum' }

    before do
      user.writing_posts.create!(content: lorem)
      user.comments.create!(content: lorem,
                            post_id: create(:post).id)
      user.friendships.create!(friend_id: friend.id)
    end

    it 'should destroy post along with user' do
      expect do
        user.destroy
      end.to change(Post, :count).by(-1)
    end

    it 'should destroy comment along with user' do
      expect do
        user.destroy
      end.to change(Comment, :count).by(-1)
    end

    it 'should destroy friendship along with user' do
      expect do
        user.destroy
      end.to change(Friendship, :count).by(-1)
    end
  end
end
