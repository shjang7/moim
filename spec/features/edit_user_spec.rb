# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'EditUser', type: :feature do
  let(:user) { create(:user, name: 'Jen Barber') }
  let(:update) { create(:user, name: 'Moris Mos') }
  before { sign_in user }

  scenario 'user update info with valid info' do
    visit user_path(user)
    click_link 'Edit info'
    fill_in 'Name', with: update.name
    fill_in 'Password', with: update.password
    fill_in 'Password confirm', with: update.password
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page.body).to have_content I18n.t("devise.registrations.updated")
    expect(current_path).to eq root_path
    click_link 'Log out'
    # Log in with updated password
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: update.password
    click_button 'Log in'
    expect(page.body).to have_content I18n.t("devise.sessions.signed_in")
    visit user_path(user)
    # name is updated
    expect(page.body).to have_content(update.name)
  end

  scenario 'user edit info with invalid info' do
    visit user_path(user)
    click_link 'Edit info'
    # try with exist user's email
    fill_in 'Email', with: update.email
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page.body).to have_content('Email has already been taken')
  end

  scenario 'user delete' do
    visit user_path(user)
    click_link 'Edit info'
    expect do
      click_button 'Cancel my account'
    end.to change(User, :count).by(-1)
    expect(page.body).to have_content I18n.t("devise.registrations.destroyed")
  end
end
