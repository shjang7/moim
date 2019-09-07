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

  context 'with instance methods' do
    let(:content) { 'Lorem ipsum' }
    let(:jen) { create(:user, name: 'Jen Barber') }
    let(:roy) { create(:user, name: 'Roy Trenneman') }
    let(:moris) { create(:user, name: 'Moris Mos') }
    let(:douglas) { create(:user, name: 'Douglas Reynholm') }
    let(:richmond) { create(:user, name: 'Richmond Avenal') }
    let(:denholm) { create(:user, name: 'Denholm Reynholm') }
    let(:jen_any_friendship_count) { [roy, moris, douglas, richmond].count }
    let(:create_friendship) do
      lambda do |user, friend, confirmed|
        user.friendships.create!(friend_id: friend.id, confirmed: confirmed)
      end
    end
    let(:include_objects?) do
      lambda do |group, objects, status|
        objects.each do |object|
          return false if status == true && !(group.include? object)
          return false if status == false && (group.include? object)
        end
        true
      end
    end
    let(:include_authors?) do
      lambda do |posts, authors, status|
        posts.each do |post|
          return false if status == true && !(authors.any? { |author| post.author.id == author.id })
          return false if status == false && (authors.any? { |author| post.author.id == author.id })
        end
        true
      end
    end
    let(:confirmed_true?) { ->(obj) { obj[:confirmed] == true } }

    before do
      create_friendship[jen, roy, true]
      create_friendship[jen, moris, true]
      create_friendship[jen, douglas, false]
      create_friendship[richmond, jen, false]
      jen.writing_posts.create!(content: content)
      post = roy.writing_posts.create!(content: content)
      douglas.writing_posts.create!(content: content)
      richmond.writing_posts.create!(content: content)
      denholm.writing_posts.create!(content: content)
      jen.comments.create!(content: content,
                           post_id: create(:post).id)
      jen.post_like_brokers.create!(post: post)
    end

    it '#friends returns confirmed friends' do
      expect(include_objects?[jen.friends, [roy, moris], true]).to eq true
    end

    it '#recommended_friends returns new friends' do
      expect(include_objects?[jen.recommended_friends, [denholm], true]).to eq true
      expect(include_objects?[jen.recommended_friends, [roy, douglas], false]).to eq true
    end

    it '#pending_friends returns sent friendship request friends' do
      expect(include_objects?[jen.pending_friends, [douglas], true]).to eq true
      expect(include_objects?[jen.pending_friends, [roy, denholm], false]).to eq true
    end

    it '#friend_requests returns received friendship request friends' do
      expect(include_objects?[jen.friend_requests, [richmond], true]).to eq true
      expect(include_objects?[jen.friend_requests, [roy, douglas, denholm], false]).to eq true
    end

    it '#confirm_friend returns friendship with confirmed status' do
      friendship = jen.confirm_friend(douglas)
      expect(confirmed_true?[friendship]).to eq true
    end

    it '#friend? returns true for confirmed friend' do
      expect(jen.friend?(roy)).to eq true
      expect(jen.friend?(moris)).to eq true
      expect(jen.friend?(douglas)).to_not eq true
      expect(jen.friend?(richmond)).to_not eq true
      expect(jen.friend?(denholm)).to_not eq true
    end

    it '#feed returns posts from user itself or friends' do
      expect(include_authors?[jen.feed, [jen, roy, moris], true]).to eq true
      expect(include_authors?[jen.feed, [douglas, richmond, denholm], false]).to eq true
    end

    it 'should destroy post along with user' do
      expect do
        jen.destroy
      end.to change(Post, :count).by(-1)
    end

    it 'should destroy comment along with user' do
      expect do
        jen.destroy
      end.to change(Comment, :count).by(-1)
    end

    it 'should destroy post like along with user' do
      expect do
        jen.destroy
      end.to change(PostLikeBroker, :count).by(-1)
    end

    it 'should destroy friendship including requests along with user' do
      expect do
        jen.destroy
      end.to change(Friendship, :count).by(-1 * jen_any_friendship_count)
    end
  end
end
