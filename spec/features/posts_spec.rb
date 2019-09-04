# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:post_params) { attributes_for(:post) }
  let(:resource_name) { { resource: 'Post' } }

  before(:all) do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
    Friendship.create!(user_id: @jen.id, friend_id: @roy.id, confirmed: true)
    @post = create(:post, author_id: @roy.id)
  end

  scenario 'user writes a post and delete' do
    sign_in @jen
    visit root_path
    # see other's post
    within(:css, '.post .author') do
      expect(page.body).to have_link(@roy.name, href: user_path(@roy))
    end
    # write post is not in other's page
    expect(page.body).to have_css('.write-post')
    visit user_path(@jen)
    expect(page.body).to have_css('.write-post')
    visit user_path(@roy)
    expect(page.body).to_not have_css('.write-post')
    # write at correct page
    visit user_path(@jen)
    expect do
      fill_in I18n.t('customs.posts.placeholder'), with: post_params[:content]
      click_button 'Submit'
    end.to change(@jen.writing_posts, :count).by(1)
    expect(page.body).to have_content I18n.t('customs.resources.create',
      resource_name)
    # user can see created post
    expect(page.body).to have_css('.post .profile-pic')
    expect(page.body).to have_css('.post .author', text: @jen.name)
    expect(page.body).to have_css('.post .timestamp')
    expect(page.body).to have_css('.post .content', text: post_params[:content])
    expect do
      click_link I18n.t('customs.buttons.delete')
    end.to change(@jen.writing_posts, :count).by(-1)
    expect(page.body).to have_content I18n.t('customs.resources.destroy.success',
      resource_name)
  end
end
