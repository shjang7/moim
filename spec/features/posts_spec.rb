# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:jen) { create(:user, name: 'Jen Barber') }
  let(:moris) { create(:user, name: 'Moris Mos') }
  let(:post_params) { attributes_for(:post) }

  scenario 'user writes a post and delete' do
    sign_in jen
    # try to write post at other's page
    visit user_path(moris)
    expect(page.body).to_not have_content I18n.t('customs.posts.placeholder')
    # write at correct page
    visit user_path(jen)
    expect do
      fill_in I18n.t('customs.posts.placeholder'), with: post_params[:content]
      click_button 'Submit'
    end.to change(jen.writing_posts, :count).by(1)
    expect(page.body).to have_content I18n.t('customs.posts.create')
    # user can see created post
    expect(page.body).to have_css('.post .profile-pic')
    expect(page.body).to have_css('.post .author', text: jen.name)
    expect(page.body).to have_css('.post .timestamp')
    expect(page.body).to have_css('.post .content', text: post_params[:content])
    expect do
      click_link 'Delete post'
    end.to change(jen.writing_posts, :count).by(-1)
    expect(page.body).to have_content I18n.t('customs.posts.destroy.success')
  end
end
