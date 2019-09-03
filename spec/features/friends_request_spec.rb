# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'FriendsRequests', type: :feature do
  before do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
  end

  scenario 'user request friends' do
    visit users_path
    expect(page.body).to have_content I18n.t('devise.failure.unauthenticated')
    sign_in @jen
    visit users_path
    expect(page.body).to_not have_content(@jen.name)
    expect(page.body).to have_content(@roy.name)
    expect(page.body).to have_css('a.friendship-request')
    click_link @roy.name
    expect(page.body).to_not have_css('.write-post')
    expect(page.body).to have_content(@roy.name)
    expect(page.body).to have_button('Request friend')
    expect do
      click_button 'Request friend'
    end.to change(Friendship, :count).by(1)
    expect(page.body).to have_content(I18n.t('customs.resources.create', resource: 'Friendship'))
    expect(page.body).to_not have_button('Request friend')
  end
end
