# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:post_params) { attributes_for(:post) }
  let(:resource_name) { { resource: 'Post' } }
  let(:edit_content) { 'It is editing' }

  before(:all) do
    @jen = create(:user, name: 'Jen Barber')
    @roy = create(:user, name: 'Roy Trenneman')
    @moris = create(:user, name: 'Moris Mos')
    Friendship.create!(user_id: @jen.id, friend_id: @roy.id, confirmed: true)
    @roy_post = create(:post, author_id: @roy.id)
    create(:post, author_id: @moris.id)
  end

  scenario 'user writes a post' do
    sign_in @jen
    visit root_path
    # see friends's post
    within(:css, '.post .author') do
      expect(page.body).to have_link(@roy.name, href: user_path(@roy))
      expect(page.body).to_not have_content(@moris.name)
    end
    # write post is not in other's page
    expect(page.body).to have_css('.write-post')
    visit user_path(@jen)
    expect(page.body).to have_css('.write-post')
    visit user_path(@roy)
    expect(page.body).to_not have_css('.write-post')
    # write at correct page
    visit user_path(@jen)
    within(:css, '#new_post') do
      expect do
        fill_in I18n.t('customs.posts.placeholder'), with: ''
        click_button 'Submit'
      end.to_not change(@jen.writing_posts, :count)
      expect do
        fill_in I18n.t('customs.posts.placeholder'), with: post_params[:content]
        click_button 'Submit'
      end.to change(@jen.writing_posts, :count).by(1)
    end
    expect(page.body).to have_content I18n.t('customs.resources.create',
                                             resource_name)
    # user can see created post from profile
    expect(page.body).to have_css('.post .profile-pic')
    expect(page.body).to have_css('.post .author', text: @jen.name)
    expect(page.body).to have_css('.post .timestamp')
    expect(page.body).to have_css('.post .content', text: post_params[:content])
    visit root_path
    # user can see created post from home
    expect(page.body).to have_css('.post .author', text: @jen.name)
  end

  scenario 'user edit and delete post' do
    sign_in @roy
    visit user_path(@roy)
    expect(page.body).to have_css('.post .author', text: @roy.name)
    within(:css, '.post-updates') do
      expect(page.body).to have_link('Edit', href: edit_post_path(@roy_post))
      click_link 'Edit'
    end
    within(:css, '.write-post') do
      fill_in I18n.t('customs.posts.placeholder'), with: edit_content
    end
    click_button 'Submit'
    expect(page.body).to have_content(edit_content)
    # user deletes post
    within(:css, '.post-updates') do
      expect do
        click_link I18n.t('customs.buttons.delete')
      end.to change(@roy.writing_posts, :count).by(-1)
    end
    expect(page.body).to have_content I18n.t('customs.resources.destroy.success',
                                             resource_name)
  end
end
