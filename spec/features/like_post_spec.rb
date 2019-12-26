require 'rails_helper'

RSpec.feature 'LikePosts', type: :feature do
  before(:all) do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
    Friendship.create!(user_id: @jen.id, friend_id: @roy.id, confirmed: true)
    @written_post = create(:post, author_id: @roy.id)
  end

  scenario 'user likes a post and unlike' do
    sign_in @jen
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
