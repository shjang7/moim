# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    let(:page_title) { Faker::App.name }
    let(:base_title) { 'Moim' }

    it 'returns base title' do
      expect(full_title).to eq base_title
    end

    it 'returns page title and base title' do
      expect(full_title(page_title)).to eq "#{page_title} | #{base_title}"
    end
  end

  describe '#users_path_with_user_id_and_page' do
    let(:jen) { create(:user, name: 'Jen Barber') }
    let(:path) { ->(user) { "/users?page=1#user-#{user.id}" } }

    it 'returns find friend path with requested friend id' do
      expect(
        users_path_with_user_id_and_page(jen, 1)
      ).to eq path[jen]
    end
  end

  describe '#users_path_for_current_friends_with_user_id' do
    let(:jen) { create(:user, name: 'Jen Barber') }
    let(:path) { ->(user) { "/users?type=current_friends&user_id=#{user.id}" } }

    it 'returns current friend path with user id' do
      expect(
        users_path_for_current_friends_with_user_id(jen)
      ).to eq path[jen]
    end
  end
end
