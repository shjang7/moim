# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @jen = create(:user)
      @post = Post.new(content: 'Lorem ipsum', author_id: @jen.id)
    end

    context 'with invalid attributes' do
      it 'is invalid without content' do
        @post.content = nil
        expect(@post).to_not be_valid
      end

      it 'is invalid without user id' do
        @post.author_id = nil
        expect(@post).to_not be_valid
      end
    end

    context 'with valid attributes' do
      it 'is valid with correct informations' do
        expect(@post).to be_valid
      end
    end
  end
end
