# frozen_string_literal: true

require 'rails_helper'

describe 'Layouts' do
  # fixtures :all
  let(:app_name) { $app_name }
  let(:owner) { double(name: 'Suhyeon Jang',
                       email: 'lucy.sh.jang@gmail.com',
                       github: 'https://github.com/shjang7') }
  let(:title) { double(base: $app_name,
                       feedback: 'Feedback',
                       sign_up: 'Sign up',
                       log_in: 'Log in',
                       password_reset: 'Password reset') }

  context 'for root path' do
    before do
      visit root_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(app_name)
    end

    it 'displays correct contents' do
      expect(page.body).to have_css 'h1.h-title', text: app_name
    end

    it 'redirects correct link' do
      expect(page.body).to have_css 'a.btn', text: 'Sign up'
      my_link = find(:css, "a:contains('Sign up')")
      my_link.click
      expect(page).to have_http_status(:success)
    end
    it 'displays correct link at footer' do
      expect(page.body).to have_css 'a.github', text: owner.name
      expect(page.body).to have_css 'a.feedback-link', text: 'Feedback'
    end
  end

  context 'for feedback path' do
    before do
      visit static_pages_feedback_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(full_title(title.feedback))
    end
    it 'displays correct contents' do
      expect(page.body).to have_css 'h1', text: 'Feedback' # changeable
      expect(page.body).to have_css 'a', text: owner.email
    end
  end

  context 'for Sign up path' do
    before do
      visit new_user_registration_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(full_title(title.sign_up))
    end
  end

  context 'for login path' do
    before do
      visit new_user_session_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(full_title(title.log_in))
    end
  end

  context 'for password reset path' do
    before do
      visit new_user_password_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(full_title(title.password_reset))
    end
  end
end
