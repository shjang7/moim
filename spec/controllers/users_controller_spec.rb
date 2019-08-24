# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:jen) { create(:user) }

    it 'returns http success' do
      get :show, params: { id: jen.id }
      expect(response).to have_http_status(:success)
    end
  end
end
