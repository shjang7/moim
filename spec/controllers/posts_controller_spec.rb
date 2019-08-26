# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    let(:jen) { create(:user) }
    let(:lorem) { 'Lorem ipsum' }

    it 'should redirect create when not logged in' do
      expect do
        post :create, params: { post: { content: lorem, author_id: jen.id } }
      end.to_not change(Post, :count)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
