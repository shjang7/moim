# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'FriendsRequests', type: :feature do
  before do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
    @post = create(:post, author_id: @roy.id)
  end

  scenario 'user request friends from find friend' do
    visit users_path
    expect(page.body).to have_content I18n.t('devise.failure.unauthenticated')
    # request friendship
    sign_in @jen
    visit users_path
    expect(page.body).to have_css('.find_friends', text: @roy.name)
    expect(page.body).to have_button I18n.t('customs.buttons.request_friend')
    expect do
      click_button I18n.t('customs.buttons.request_friend')
    end.to change(Friendship, :count).by(1)
    expect(page.body).to have_content I18n.t('customs.friendships.request')
    expect(page.body).to_not have_button I18n.t('customs.buttons.request_friend')
    expect(page.body).to have_css('.pending_friends', text: @roy.name)
    expect(page.body).to have_css('.pending_friends',
                                  text: I18n.t('customs.buttons.pending_friend'))
    expect(page.body).to_not have_css('.find_friends', text: @roy.name)
    sign_out @jen
    # accept friendship
    sign_in @roy
    visit users_path
    expect(page.body).to_not have_css('.find_friends', text: @jen.name)
    expect(page.body).to have_css('.friend_requests', text: @jen.name)
    expect(page.body).to have_button I18n.t('customs.buttons.accept_friend')
    click_button I18n.t('customs.buttons.accept_friend')
    expect(Friendship.find_by(friend_id: @roy.id, user_id: @jen.id).confirmed)
      .to eq true
    expect(page.body).to have_content I18n.t('customs.friendships.accept')
    expect(page.body).to_not have_css('.friend_requests', text: @jen.name)
    # delete friendship
    visit user_path(@roy)
    within(:css, '.friends-info') do
      expect(page.body).to have_link(@jen.name, href: user_path(@jen))
      click_link @jen.name
    end
    expect do
      click_button I18n.t('customs.buttons.delete_friend')
    end.to change(Friendship, :count).by(-1)
  end

  scenario 'user request friends from find friend, but in their profile' do
    sign_in @jen
    visit users_path
    expect(page.body).to have_content(@roy.name)
    click_link @roy.name
    within(:css, '.profile-info') do
      expect(page.body).to have_button I18n.t('customs.buttons.request_friend')
    end
    expect do
      click_button I18n.t('customs.buttons.request_friend')
    end.to change(Friendship, :count).by(1)
    expect(page.body).to_not have_button I18n.t('customs.buttons.request_friend')
    expect(page.body).to have_content I18n.t('customs.buttons.pending_friend')
  end
end
