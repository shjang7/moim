# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'LikePosts', type: :feature do
  let(:user) { create(:user) }
  let(:written_post) { create(:post) }

  scenario 'user writes a comment and delete' do
    sign_in user
    written_post
    visit root_path
    # for like
    expect do
      click_button 'Like'
    end.to change(written_post.likers, :count).by(1)
    # for unlike
    expect do
      click_button 'Like'
    end.to change(written_post.likers, :count).by(-1)
  end
end
