# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignUp', type: :feature do
  let(:title) { full_title(I18n.t('customs.titles.signup')) }
  let(:valid_attributes) { attributes_for(:user) }

  scenario 'user signs up' do
    visit root_path
    expect(page).to have_link('Sign up', href: new_user_registration_path)
    click_link 'Sign up'
    expect(page.body).to have_title(title)
    expect do
      fill_in 'Name', with: valid_attributes[:name]
      fill_in 'Email', with: valid_attributes[:email]
      fill_in 'Password', with: valid_attributes[:password]
      fill_in 'Password confirmation', with: valid_attributes[:password]
      click_button 'Sign up'
    end.to change(User, :count).by(1)
    expect(page.body).to have_content I18n.t('devise.registrations.signed_up')
  end
end
