# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Layouts', type: :feature do
  let(:user) { create(:user) }
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

  scenario 'user moves page to page' do
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
    expect(page.body).to_not have_link(I18n.t('customs.navbars.profile'),
                                       href: user_path(user))
    expect(page.body).to_not have_link(I18n.t('customs.navbars.find_friends'),
                                       href: users_path)
    expect(page.body).to_not have_link(I18n.t('customs.navbars.logout'),
                                       href: destroy_user_session_path)
    visit new_user_session_path
    expect(page.body).to have_title(title.login)
    sign_in user
    # header changed
    visit root_path
    expect(page.body).to have_link(I18n.t('customs.navbars.profile'),
                                   href: user_path(user))
    expect(page.body).to have_link(I18n.t('customs.navbars.home'),
                                   href: root_path)
    expect(page.body).to have_link(I18n.t('customs.navbars.find_friends'),
                                   href: users_path)
    expect(page.body).to have_link(I18n.t('customs.navbars.logout'),
                                   href: destroy_user_session_path)
    # profile
    visit user_path(user)
    expect(page.body).to have_title(title.user_name)
    # user index
    visit users_path
    expect(page.body).to have_title(title.find_friends)
    visit users_path(type: 'pending_friends')
    expect(page.body).to have_title(title.pending_friends)
    visit users_path(type: 'current_friends')
    expect(page.body).to have_title(title.current_friends)
    # feedback
    visit feedback_path
    expect(page.body).to have_title(title.feedback)
    expect(page.body).to have_link(I18n.t('customs.author.email'),
                                   href: "mailto:#{I18n.t('customs.author.email')}?Subject=Feedback")
  end
end
