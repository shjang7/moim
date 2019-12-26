require 'rails_helper'

RSpec.describe PostLikeBroker, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { PostLikeBroker.new(user_id: user.id, post_id: post.id) }
  context 'with valid attributes' do
    it 'is valid' do
      expect(like).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should require a user_id' do
      like.user_id = nil
      expect(like).to_not be_valid
    end

    it 'should require a post_id' do
      like.post_id = nil
      expect(like).to_not be_valid
    end
  end

  context 'Associations relationships' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to post' do
      assc = described_class.reflect_on_association(:post)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
