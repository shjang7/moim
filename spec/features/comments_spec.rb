# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  let(:comment) { 'Lorem ipsum for comment' }

  before(:all) do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
    Friendship.create!(user_id: @jen.id, friend_id: @roy.id, confirmed: true)
    @written_post = create(:post, author_id: @roy.id)
  end

  scenario 'user writes a comment and delete' do
    sign_in @jen
    visit root_path
    # create
    expect(page.body).to have_css('.author', text: @roy.name)
    expect do
      within(:css, '#new_comment') do
        fill_in I18n.t('customs.comments.placeholder'), with: comment
        click_button I18n.t('customs.buttons.submit')
      end
    end.to change(Comment, :count).by(1)
    expect(page.body).to have_content(comment)
    # delete
    expect do
      within(:css, '.comments li') do
        click_link I18n.t('customs.buttons.delete')
      end
    end.to change(Comment, :count).by(-1)
    expect(page.body).to_not have_content(comment)
  end
end
