# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'FriendsRequests', type: :feature do
  let(:jen) { create(:user, name: 'Jen Barber') }

  before do
    @roy = create(:user, name: 'Roy Trenneman')
    @moris = create(:user, name: 'Moris Mos')
  end

  scenario 'user request friends' do
    visit users_path
    expect(page.body).to have_content I18n.t('devise.failure.unauthenticated')
    sign_in jen
    visit users_path
    expect(page.body).to_not have_content(jen.name)
    expect(page.body).to have_content(@roy.name)
    expect(page.body).to have_css('a.friendship-request')
    click_link @roy.name
    expect(page.body).to have_content(@roy.name)
    expect(page.body).to have_css('a.friendship-request', text: 'Request friend')
    expect(page.body).to_not have_css('.write-post')
  end
end
