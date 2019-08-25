# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = create(:post)
    end

    context 'with invalid attributes' do
      it 'is invalid without content' do
        @post.content = nil
        expect(@post).to_not be_valid
      end

      it 'is invalid without author id' do
        @post.author_id = nil
        expect(@post).to_not be_valid
      end

      it 'is invalid without right content' do
        @post.content = ' ' * 6
        expect(@post).to_not be_valid
      end
    end

    context 'with valid attributes' do
      it 'is valid with correct informations' do
        expect(@post).to be_valid
      end

      it 'sorts descending order' do
        0.upto(5) do
          create(:post,
                 created_at: Faker::Date.between(from: 50.days.ago, to: 1.day.ago))
        end
        expect(Post.first).to eq(@post)
      end
    end
  end
end
