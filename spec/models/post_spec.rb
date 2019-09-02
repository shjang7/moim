# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:lorem) { 'Lorem ipsum' }

  context 'with valid attributes' do
    let(:posts) { Post.all }
    before(:all) do
      0.upto(5) do
        create(:post,
               created_at: Faker::Date.between(from: 50.days.ago, to: Date.today))
      end
    end

    it 'is valid with correct informations' do
      post = Post.new(content: lorem, author_id: user.id)
      expect(post).to be_valid
    end

    it 'sorts descending order' do
      posts[0...(posts.size - 1)].each_with_index do |_, i|
        recent = posts[i].created_at
        older = posts[i + 1].created_at
        expect(recent - older).to be >= 0
      end
    end

    it 'generates associated data from a factory' do
      post = create(:post)
      expect(post.author_id).to eq post.author.id
    end
  end

  context 'with invalid attributes' do
    let(:post) { create(:post) }

    it 'is invalid without a content' do
      post.content = nil
      expect(post).to_not be_valid
    end

    it 'is invalid without an author id' do
      post.author_id = nil
      expect(post).to_not be_valid
    end

    it 'is invalid without right content' do
      post.content = ' ' * 10
      expect(post).to_not be_valid
    end
  end

  context 'with associated post likes' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'should like and unlike posts' do
      expect(post.liker?(user)).to_not eq true
      post.liker_add(user)
      expect(post.liker?(user)).to eq true
      expect(user.liked_posts.include?(post)).to eq true
      post.liker_remove(user)
      expect(post.liker?(user)).to_not eq true
    end
  end
end
