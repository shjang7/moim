# frozen_string_literal: true

require 'rails_helper'

describe 'Layouts' do
  let(:root_path) { '/' }
  let(:feedback_path) { '/static_pages/feedback' }
  let(:app_name) { $app_name }
  let(:owner) { double(name: 'Suhyeon Jang',
                       email: 'lucy.sh.jang@gmail.com',
                       github: 'https://github.com/shjang7') }

  context 'for root_path' do
    before do
      visit root_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(app_name)
    end
    it 'displays correct link' do
      expect(page.body).to have_css 'h1.h-title', text: app_name
      expect(page.body).to have_css 'a.btn', text: 'Sign up'
    end
    it 'displays correct link at footer' do
      expect(page.body).to have_css 'a.github', text: owner.name
      expect(page.body).to have_css 'a.feedback-link', text: 'Feedback'
    end
  end

  context 'for feedback' do
    before do
      visit feedback_path
    end
    it 'displays correct title' do
      expect(page.body).to have_title(full_title('Feedback'))
    end
    it 'displays correct link' do
      expect(page.body).to have_css 'h1', text: 'Feedback'
      expect(page.body).to have_css 'a', text: owner.email
    end
  end
end
