# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) do
    Comment.new(content: 'Lorem ipsum',
                post_id: post.id,
                user_id: user.id)
  end
  let(:comments) { Comment.all }
  before(:all) do
    post_for_all = create(:post)
    0.upto(5) do
      Comment.create(content: 'Lorem ipsum',
                     post_id: post_for_all.id,
                     user_id: create(:user).id,
                     created_at: Faker::Date.between(from: 50.days.ago, to: Date.today))
    end
  end
  context 'with valid attributes' do
    it 'is valid' do
      expect(comment).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should require a content' do
      comment.content = nil
      expect(comment).to_not be_valid
    end

    it 'should require a post_id' do
      comment.post_id = nil
      expect(comment).to_not be_valid
    end

    it 'should require a user_id' do
      comment.user_id = nil
      expect(comment).to_not be_valid
    end

    it 'content should be present' do
      comment.content = ' ' * 6
      expect(comment).to_not be_valid
    end

    it 'sorts descending order' do
      comments[0...(comments.size - 1)].each_with_index do |_, i|
        recent = comments[i].created_at
        older = comments[i + 1].created_at
        expect(recent - older).to be >= 0
      end
    end
  end
end
