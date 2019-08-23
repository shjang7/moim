# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
      # expect(page.body).to have_title('Moim')
      # title = Moim
    end
  end

  describe 'GET #feedback' do
    it 'returns http success' do
      get :feedback
      expect(response).to have_http_status(:success)
      # title = Feedback | Moim
    end
  end
end
