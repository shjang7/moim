# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignIns', type: :feature do
  let(:user) { create(:user) }

  scenario 'user log in and log out' do
    visit root_path
    expect(page.body).to_not have_content('Profile')
    expect(page.body).to have_content('Home')
    expect(page.body).to_not have_content('Find Friends')
    expect(page.body).to_not have_content('Log out')
    # Log in
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    # alert message
    expect(page.body).to have_content I18n.t("devise.sessions.signed_in")
    expect(current_path).to eq root_path
    # header changed
    expect(page.body).to have_content('Profile')
    expect(page.body).to have_content('Home')
    expect(page.body).to have_content('Find Friends')
    expect(page.body).to have_content('Log out')
    # Post list partial
    expect(page.body).to have_content('Posts')
    # Access user profile
    click_link 'Profile'
    expect(page.body).to have_css('.profile-info .h-title', text: user.name)
    # Log out
    click_link 'Log out'
    expect(page.body).to have_content I18n.t("devise.sessions.signed_out")
  end
end
