# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    let(:posts) { Post.all }
    before(:all) do
      0.upto(5) do
        create(:post,
               created_at: Faker::Date.between(from: 50.days.ago, to: Date.today))
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without content' do
        post = build(:post, content: nil)
        expect(post).to_not be_valid
      end

      it 'is invalid without author id' do
        post = build(:post, author_id: nil)
        expect(post).to_not be_valid
      end

      it 'is invalid without right content' do
        post = build(:post, content: ' ' * 10)
        expect(post).to_not be_valid
      end
    end

    context 'with valid attributes' do
      it 'is valid with correct informations' do
        post = create(:post)
        expect(post).to be_valid
      end

      it 'sorts descending order' do
        posts[0...(posts.size - 1)].each_with_index do |_, i|
          recent = posts[i].created_at
          older = posts[i + 1].created_at
          expect(recent - older).to be >= 0
        end
      end
    end
  end
end
