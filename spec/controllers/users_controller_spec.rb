# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:other) { create(:user) }

    it 'returns no success when not logged in' do
      get :show, params: { id: user.id }
      expect(response).to_not have_http_status(:success)
    end

    it 'returns http success when logged in' do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns http success from logged in visiters' do
      sign_in other
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
