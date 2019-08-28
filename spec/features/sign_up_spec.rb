# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignUps', type: :feature do
  let(:valid_attributes) { attributes_for(:user) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  scenario 'user successfully signs up' do
    visit root_path
    click_link 'Sign up'
    expect do
      fill_in 'Name', with: valid_attributes[:name]
      fill_in 'Email', with: valid_attributes[:email]
      fill_in 'Password', with: valid_attributes[:password]
      fill_in 'Password confirmation', with: valid_attributes[:password]
      click_button 'Sign up'
    end.to change(User, :count).by(1)
    expect(page.body).to have_css('.alert-notice',
                                  text: 'Welcome! You have signed up successfully.')
  end
end
