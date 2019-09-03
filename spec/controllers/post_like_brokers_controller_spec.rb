# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostLikeBrokersController, type: :controller do
  describe 'POST_LIKE_BROKER #create' do
    it 'creates should require logged-in user' do
      expect do
        post :create, params: { post: create(:post) }
      end.to_not change(PostLikeBroker, :count)
    end
  end
end
