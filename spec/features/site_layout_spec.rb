# frozen_string_literal: true

require 'rails_helper'

describe 'Layouts' do
  let(:app) do
    double(name: $app_name)
  end

  let(:admin) do
    double(name: 'Suhyeon Jang',
           email: 'lucy.sh.jang@gmail.com',
           github: 'https://github.com/shjang7')
  end

  let(:title) do
    double(base: $app_name,
           feedback: 'Feedback',
           sign_up: 'Sign up',
           log_in: 'Log in',
           password_reset: 'Password reset')
  end

  context 'for root path' do
    before do
      visit root_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(app.name)
    end

    it 'displays correct contents' do
      # expect(page.body).to have_css 'h1.h-title', text: app.name
      expect(page).to have_link('Sign up', href: new_user_registration_url)
    end
  end

  context 'for header path' do
    before do
      visit root_path
    end

    it 'redirects correct link' do
      expect(page).to have_link(app.name, href: root_url)
    end
  end

  context 'for footer path' do
    before do
      visit root_path
    end

    it 'redirects correct link' do
      expect(page).to have_link(admin.name, href: admin.github)
      expect(page).to have_link('Feedback', href: static_pages_feedback_path)
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
      expect(page.body).to have_css 'h1', text: 'Feedback'
      expect(page.body).to have_css 'a', text: admin.email
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
