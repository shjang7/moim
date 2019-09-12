# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignIn', type: :feature do
  let(:user) { create(:user) }

  scenario 'user log in and log out' do
    visit root_path
    expect(page.body).to have_link('Log in', href: new_user_session_path)
    # Log in
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    # alert message
    expect(page.body).to have_content I18n.t('devise.sessions.signed_in')
    expect(current_path).to eq root_path
    # Post list partial
    expect(page.body).to have_content('Posts')
    # Access user profile
    click_link user.name.familiar
    expect(page.body).to have_css('.profile-info', text: user.name)
    expect(page.body).to have_link(
      I18n.t('customs.buttons.edit_user_info'), href: edit_user_registration_path
    )
    # Log out
    expect(page).to have_link(
      'Log out', href: destroy_user_session_path
    )
    click_link 'Log out'
    expect(page.body).to have_content I18n.t('devise.sessions.signed_out')
  end
end
