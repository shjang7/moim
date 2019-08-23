# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    let(:page_title) { Faker::App.name }
    let(:base_title) { $app_name }

    it 'returns base title' do
      expect(full_title).to eq base_title
    end

    it 'returns page title and base title' do
      expect(full_title(page_title)).to eq "#{page_title} | #{base_title}"
    end
  end
end
