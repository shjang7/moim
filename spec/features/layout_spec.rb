# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Layouts', type: :feature do
  let(:user) { create(:user) }
  let(:admin) { double(email: 'lucy.sh.jang@gmail.com') }
  let(:title) do
    double(base: 'Moim',
           login: full_title('Log in'),
           user_name: full_title(user.name),
           find_friends: full_title('Find Friends'),
           feedback: full_title('Feedback'))
  end

  scenario 'user moves page to page' do
    visit root_path
    expect(page.body).to have_title(title.base)
    # non signed user can only access signup/login button from home
    expect(page.body).to have_content('Sign up')
    expect(page.body).to have_content('Log in')
    expect(page.body).to have_content('Log in with facebook')
    expect(page.body).to have_css('header', text: 'Home')
    # non signed in user cannot access any other features
    expect(page.body).to_not have_css('header', text: 'Profile')
    expect(page.body).to_not have_css('header', text: 'Find Friends')
    expect(page.body).to_not have_css('header', text: 'Log out')
    # visit log in path
    visit new_user_session_path
    expect(page.body).to have_title(title.login)
    sign_in user
    # header changed
    visit root_path
    expect(page.body).to have_css('header', text: 'Profile')
    expect(page.body).to have_css('header', text: 'Home')
    expect(page.body).to have_css('header', text: 'Find Friends')
    expect(page.body).to have_css('header', text: 'Log out')
    # profile
    visit user_path(user)
    expect(page.body).to have_title(title.user_name)
    # user list
    visit users_path
    expect(page.body).to have_title(title.find_friends)
    visit feedback_path
    expect(page.body).to have_title(title.feedback)
    expect(page.body).to have_link(admin.email,
                                   href: 'mailto:lucy.sh.jang@gmail.com?Subject=Feedback')
  end
end
