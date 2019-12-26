require 'rails_helper'

RSpec.feature 'OmniAuthFacebook', type: :feature do
  before(:each) do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  it 'returns http success for authorization path' do
    visit user_facebook_omniauth_authorize_path
    expect(page).to have_http_status(:success)
  end

  it 'returns http success for callback path' do
    visit user_facebook_omniauth_callback_path
    expect(page).to have_http_status(:success)
  end

  scenario 'sign in and out with facebook account' do
    visit root_path
    expect(page).to have_link(
      'Log in with facebook', href: user_facebook_omniauth_authorize_url
    )
    click_link 'Log in with facebook'
    expect(current_path).to eq root_path
    expect(page.body).to have_css(
      '.alert-notice', text: I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook')
    )
    expect(page.body).to have_css('nav', text: 'Jen B.')
    click_link 'Jen B.'
    expect(page.body).to_not have_link(
      I18n.t('customs.buttons.edit_user_info'), href: edit_user_registration_path
    )
    expect(page).to have_link(
      'Log out', href: destroy_user_session_path
    )
    click_link 'Log out'
    expect(page.body).to have_content I18n.t('devise.sessions.signed_out')
  end
end
