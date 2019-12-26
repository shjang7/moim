require 'rails_helper'

RSpec.feature 'FriendsRequests', type: :feature do
  let(:previous_friend_count) { 1 }
  let(:after_friend_count) { 2 }
  before do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
    @moris = create(:user, name: 'Moris Mos')
    @richmond = create(:user, name: 'Richmond Avenal')
    @post = create(:post, author_id: @roy.id)
    # mutual friend : moris
    create(:friendship, user_id: @jen.id, friend_id: @moris.id, confirmed: true)
    create(:friendship, user_id: @roy.id, friend_id: @moris.id, confirmed: true)
  end

  scenario 'user request friends from find friend' do
    visit users_path
    expect(page.body).to have_content I18n.t('devise.failure.unauthenticated')
    # request friendship
    sign_in @jen
    visit users_path
    expect(page.body).to have_css('.recommended_friends ol li .user-name', text: @roy.name)
    expect(page.body).to have_css('.new_friends ol li .user-name', text: @richmond.name)
    within(:css, '.recommended_friends') do
      expect(page.body).to have_css('.recommended_friends ol li.user')
      expect(@jen.pending_friends.count).to eq 0
      click_button I18n.t('customs.buttons.request_friend')
      expect(@jen.pending_friends.count).to eq 1
      expect(page.body).to have_content I18n.t('customs.friendships.create')
      expect(page.body).to_not have_css('.recommended_friends ol li.user')
    end
    expect(page.body).to have_link(
      I18n.t('customs.links.pending_friends'), href: users_path(type: 'pending_friends')
    )
    click_link I18n.t('customs.links.pending_friends')
    expect(page.body).to have_css('.pending_friends ol li .user-name', text: @roy.name)
    expect(page.body).to have_css('.pending_friends',
                                  text: I18n.t('customs.buttons.pending_friend'))
    sign_out @jen
    # for accepting friendship, login with roy
    sign_in @roy
    visit root_path
    within(:css, '.dropdown-menu') do
      expect(page.body).to have_link(@jen.name, href: users_path_with_user_id_and_page(@jen, 1))
      click_link "#{@jen.name} sent you a friend request that you haven't responded to yet"
    end
    expect(page.body).to have_css('.friend_requests', text: @jen.name)
    within(:css, '.friend_requests') do
      expect(@jen.friend?(@roy)).to eq false
      expect(page.body).to have_button I18n.t('customs.buttons.accept_friend')
    end
    expect(@jen.friends.count).to be previous_friend_count
    expect(@roy.friends.count).to be previous_friend_count
    click_button I18n.t('customs.buttons.accept_friend')
    expect(@jen.friends.count).to be after_friend_count
    expect(@roy.friends.count).to be after_friend_count
    expect(@roy.friend?(@jen)).to eq true
    expect(@jen.friend?(@roy)).to eq true
    expect(page.body).to have_css('.alert-notice', text: I18n.t('customs.friendships.update'))
    expect(page.body).to_not have_css('.friend_requests', text: @jen.name)
    visit user_path(@roy)
    expect(page.body).to have_link("Friends: #{after_friend_count}", href: users_path_for_current_friends_with_user_id(@roy))
    click_link "Friends: #{after_friend_count}"
    within(:css, '.current_friends') do
      expect(page.body).to have_link(@jen.name, href: user_path(@jen))
    end
    # delete friendship
    expect(@roy.friend?(@jen)).to eq true
    within(:css, "#user-#{@jen.id}") do
      click_button I18n.t('customs.buttons.cancel_friend')
    end
    expect(@jen.friends.count).to be previous_friend_count
    expect(@roy.friends.count).to be previous_friend_count
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
    # cancel request friendship
    expect do
      click_button I18n.t('customs.buttons.cancel_request')
    end.to change(Friendship, :count).by(-1)
    expect(page).to have_current_path root_path
    expect(page.body).to have_css(
      '.alert-notice', text: I18n.t('customs.resources.destroy.success', resource: 'Friendship')
    )
    # request again
    visit user_path(@roy)
    expect do
      click_button I18n.t('customs.buttons.request_friend')
    end.to change(Friendship, :count).by(1)
    expect(page.body).to_not have_button I18n.t('customs.buttons.request_friend')
    expect(page.body).to have_content I18n.t('customs.buttons.pending_friend')
    sign_out @jen
    sign_in @roy
    visit user_path(@jen)
    within(:css, '.profile-info') do
      expect(page.body).to have_button I18n.t('customs.buttons.accept_friend')
    end
    # cancel accept friendship
    expect do
      click_button I18n.t('customs.buttons.cancel_request')
    end.to change(Friendship, :count).by(-1)
  end
end
