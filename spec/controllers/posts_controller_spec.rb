# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    let(:post_params) { attributes_for(:post) }

    it 'should not write post when not logged in' do
      expect do
        post :create, params: { post: post_params }
      end.to_not change(Post, :count)
    end
  end
end
