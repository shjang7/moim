# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  let(:user) { create(:user) }
  let(:written_post) { create(:post) }
  let(:comment) { 'Lorem ipsum for comment' }

  scenario 'user writes a comment and delete' do
    sign_in user
    written_post
    visit root_path
    # create
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
