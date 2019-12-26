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

  describe 'POST #index' do
    let(:user) { create(:user) }

    it 'returns http no success when not logged in' do
      get :index
      expect(response).to_not have_http_status(:success)
    end

    it 'returns http success' do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
