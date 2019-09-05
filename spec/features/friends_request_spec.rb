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
    expect(page.body).to_not have_css('.find_friends', text: @roy.name)
    expect(page.body).to have_link(
      'view sent requests', href: users_path(type: 'pending_friends')
    )
    click_link 'view sent requests'
    expect(page.body).to have_css('.pending_friends', text: @roy.name)
    expect(page.body).to have_css('.pending_friends',
                                  text: I18n.t('customs.buttons.pending_friend'))
    sign_out @jen
    # for accepting friendship, login with roy
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: @roy.email
    fill_in 'Password', with: @roy.password
    click_button 'Log in'
    # friend request alarm
    expect(page.body).to have_content(
      "#{I18n.t('devise.sessions.signed_in')} Friend request : 1"
    )
    visit users_path
    expect(page.body).to_not have_css('.find_friends', text: @jen.name)
    expect(page.body).to have_css('.friend_requests', text: @jen.name)
    expect(page.body).to have_button I18n.t('customs.buttons.accept_friend')
    expect(@jen.friend?(@roy)).to eq false
    expect do
      click_button I18n.t('customs.buttons.accept_friend')
    end.to change(@roy.friends, :count).by(1)
    expect(@jen.friend?(@roy)).to eq true
    expect(page.body).to have_content I18n.t('customs.friendships.accept')
    expect(page.body).to_not have_css('.friend_requests', text: @jen.name)
    visit user_path(@roy)
    expect(page.body).to have_link('More', href: users_path(type: 'current_friends'))
    click_link 'More'
    within(:css, '.current_friends') do
      expect(page.body).to have_link(@jen.name, href: user_path(@jen))
    end
    # delete friendship
    expect(@roy.friend?(@jen)).to eq true
    expect do
      click_button I18n.t('customs.buttons.delete_friend')
    end.to change(@jen.friends, :count).by(-1)
    expect(@roy.friend?(@jen)).to eq false
  end

  scenario 'user request friends from their profile through find friend page' do
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
