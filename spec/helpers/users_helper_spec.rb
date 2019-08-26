# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#profile_img_for' do
    let(:jen) { create(:user) }

    it 'returns image tag' do
      method = profile_img_for(jen)
      expect(method).to have_css 'img'
    end
  end
end
