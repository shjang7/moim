# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    it 'returns http success' do
      get :home
      puts page.body
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #feedback' do
    it 'returns http success' do
      get :feedback
      expect(response).to have_http_status(:success)
    end
  end
end
