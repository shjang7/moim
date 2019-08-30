# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Layouts', type: :feature do
  let(:user) { create(:user) }
  let(:title) do
    double(base: I18n.t('customs.app.name'),
           login: full_title(I18n.t('customs.titles.login')),
           user_name: full_title(user.name),
           find_friends: full_title(I18n.t('customs.titles.users_index')),
           feedback: full_title(I18n.t('customs.titles.feedback')))
  end

  scenario 'user moves page to page' do
    visit root_path
    expect(page.body).to have_title(title.base)
    # non signed user can only access signup/login button from home
    expect(page.body).to have_content(I18n.t('customs.buttons.signup'))
    expect(page.body).to have_content(I18n.t('customs.buttons.login'))
    expect(page.body).to have_content(I18n.t('customs.buttons.facebook_login'))
    expect(page.body).to have_css('header', text: I18n.t('customs.navbars.home'))
    # non signed in user cannot access any other features
    expect(page.body).to_not have_css('header', text: I18n.t('customs.navbars.profile'))
    expect(page.body).to_not have_css('header', text: I18n.t('customs.navbars.find_friends'))
    expect(page.body).to_not have_css('header', text: I18n.t('customs.navbars.logout'))
    # visit log in path
    visit new_user_session_path
    expect(page.body).to have_title(title.login)
    sign_in user
    # header changed
    visit root_path
    expect(page.body).to have_css('header', text: I18n.t('customs.navbars.profile'))
    expect(page.body).to have_css('header', text: I18n.t('customs.navbars.home'))
    expect(page.body).to have_css('header', text: I18n.t('customs.navbars.find_friends'))
    expect(page.body).to have_css('header', text: I18n.t('customs.navbars.logout'))
    # profile
    visit user_path(user)
    expect(page.body).to have_title(title.user_name)
    # user list
    visit users_path
    expect(page.body).to have_title(title.find_friends)
    visit feedback_path
    expect(page.body).to have_title(title.feedback)
    expect(page.body).to have_link(I18n.t('customs.author.email'),
      href: "mailto:#{I18n.t('customs.author.email')}?Subject=Feedback")
  end
end
