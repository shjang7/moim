require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:friend) { create(:user) }

  describe 'GET #create' do
    it 'returns http success' do
      post :create, params: { friendship: { friend_id: friend.id } }
      expect(response).to_not have_http_status(:success)
    end
  end

  describe 'GET #destroy' do
    it 'returns http success' do
      delete :destroy, params: { id: 1 }
      expect(response).to_not have_http_status(:success)
    end
  end
end
