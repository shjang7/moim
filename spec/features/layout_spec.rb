# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Layouts', type: :feature do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:second_friend) { create(:user) }
  let(:pending_friend) { create(:user) }
  let(:request_friend) { create(:user) }
  let(:friend_count) { 2 }
  let(:recommended_user) { create(:user) }
  let(:no_related_user) { create(:user) }
  let(:title) do
    double(base: I18n.t('customs.app.name'),
           login: full_title(I18n.t('customs.titles.login')),
           user_name: full_title(user.name),
           current_friends: full_title(I18n.t('customs.titles.current_friends',
                                              name: user.name.possessive)),
           pending_friends: full_title(I18n.t('customs.titles.pending_friends')),
           find_friends: full_title(I18n.t('customs.titles.find_friends')),
           feedback: full_title(I18n.t('customs.titles.feedback')))
  end
  before do
    create(:post, author_id: user.id)
    create(:friendship, user_id: user.id, friend_id: friend.id, confirmed: true)
    create(:friendship, user_id: second_friend.id, friend_id: user.id, confirmed: true)
    create(:friendship, user_id: user.id, friend_id: pending_friend.id)
    create(:friendship, user_id: request_friend.id, friend_id: user.id)
    create(:friendship, user_id: recommended_user.id, friend_id: second_friend.id, confirmed: true)
    recommended_user
    no_related_user
  end

  scenario 'user in root page before login' do
    visit root_path
    expect(page.body).to have_title(title.base)
    # non signed user can only access signup/login button from home
    expect(page.body).to have_link(I18n.t('customs.buttons.signup'),
                                   href: new_user_registration_path)
    expect(page.body).to have_link(I18n.t('customs.buttons.login'),
                                   href: new_user_session_path)
    expect(page.body).to have_content(I18n.t('customs.buttons.facebook_login'))
    expect(page.body).to have_link(I18n.t('customs.navbars.home'), href: root_path)
    # non signed in user cannot access any other features
    expect(page.body).to_not have_link(user.name.familiar,
                                       href: user_path(user))
    expect(page.body).to_not have_link(I18n.t('customs.navbars.find_friends'),
                                       href: users_path)
    expect(page.body).to_not have_link(I18n.t('customs.navbars.logout'),
                                       href: destroy_user_session_path)
  end

  scenario 'user in root page with login' do
    visit new_user_session_path
    expect(page.body).to have_title(title.login)
    sign_in user
    visit root_path
    expect(page.body).to have_link(user.name.familiar,
                                   href: user_path(user))
    expect(page.body).to have_link(I18n.t('customs.navbars.home'),
                                   href: root_path)
    expect(page.body).to have_link(I18n.t('customs.navbars.find_friends'),
                                   href: users_path)
    expect(page.body).to have_link(I18n.t('customs.navbars.logout'),
                                   href: destroy_user_session_path)
  end

  scenario 'user in profile page' do
    sign_in user
    visit user_path(user)
    expect(page.body).to have_title(title.user_name)
    expect(page.body).to have_link(I18n.t('customs.buttons.edit_user_info'),
                                   href: edit_user_registration_path)
    # post write or see
    expect(page.body).to have_css('.write-post textarea')
    expect(page.body).to have_css('.posts .post .author', text: user.name)
    within(:css, '.friends-info .h-title') do
      expect(page.body).to have_link('Find Friends', href: users_path)
    end
    within(:css, '.friends-info') do
      expect(page.body).to have_link("Friends: #{friend_count}", href: users_path_for_current_friends_with_user_id(user))
      click_link "Friends: #{friend_count}"
    end
    # user's all friends
    expect(page.body).to have_title(title.current_friends)
    within(:css, '#current_friends ol') do
      expect(page.body).to have_css('.user-name', text: friend.name)
      expect(page.body).to have_css('.user-name', text: second_friend.name)
    end
  end

  scenario 'user in find friend page' do
    sign_in user
    visit users_path
    expect(page.body).to have_title(title.find_friends)
    within(:css, '#friend_requests ol') do
      expect(page.body).to have_css('.user-name', text: request_friend.name)
    end
    within(:css, '#find_friends ol') do
      expect(page.body).to_not have_css('.user-name', text: no_related_user.name)
      expect(page.body).to have_css('.user-name', text: recommended_user.name)
    end
    expect(page.body).to have_link(I18n.t('customs.links.pending_friends'), href: users_path(type: 'pending_friends'))
    click_link I18n.t('customs.links.pending_friends')
    expect(page.body).to have_title(title.pending_friends)
    within(:css, '#pending_friends ol') do
      expect(page.body).to have_css('.user-name', text: pending_friend.name)
    end
  end

  scenario 'user in other pages' do
    # feedback
    visit feedback_path
    expect(page.body).to have_title(title.feedback)
    expect(page.body).to have_link(I18n.t('customs.author.email'),
                                   href: "mailto:#{I18n.t('customs.author.email')}?Subject=Feedback")
  end
end
