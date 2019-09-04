# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'LikePosts', type: :feature do
  let(:user) { create(:user) }
  before(:all) do
    @written_post = create(:post)
  end

  scenario 'user writes a comment and delete' do
    sign_in user
    visit root_path
    # for like
    expect do
      click_button 'Like'
    end.to change(@written_post.likers, :count).by(1)
    # for unlike
    expect do
      click_button 'Like'
    end.to change(@written_post.likers, :count).by(-1)
  end
end
