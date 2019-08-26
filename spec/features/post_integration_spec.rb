# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Post integration test', type: :request do
  let(:jen) { create(:user) }
  let(:lorem) { 'Lorem ipsum' }

  # it 'redirects create when not logged in' do
  #   expect do
  #     post posts_path, params: { post: { content: lorem } }
  #   end.to change(Post, :count).by(0)
  #   expect(response).to_not have_http_status(:success)
  #   expect(response).to redirect_to new_user_session_path
  #   expect(flash[:alert])
  #     .to eq "You need to sign in or sign up before continuing."
  # end

  it 'creates post when logged in' do
    sign_in jen
    # post = jen.writing_posts.build(content: lorem)
    expect do
      post posts_path, params: { post: { content: lorem } }
    end.to change(Post, :count).by(1)
    # expect(flash[:success]).to eq 'Post created!'
    # fallback location : root
    # expect(response).to redirect_to root_path
    # expect do
  end
end

# describe 'DELETE #destroy' do
#   # sign_in
# end
