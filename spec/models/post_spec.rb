# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    let(:jen) { create(:user) }

    context 'with invalid attributes' do
      it 'does not add a post' do
      end
    end

    context 'with valid attributes' do
      it 'does add a post' do
      end
    end
  end
end
