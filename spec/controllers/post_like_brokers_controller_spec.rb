require 'rails_helper'

RSpec.describe PostLikeBrokersController, type: :controller do
  let(:post_params) { attributes_for(:post) }

  describe 'POST_LIKE_BROKER #create' do
    it 'creates should require logged-in user' do
      expect do
        post :create, params: { post: post_params }
      end.to_not change(PostLikeBroker, :count)
      # puts page.body
      # expect(page.body).to have_css('div#errors')
    end
  end
end
