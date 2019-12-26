require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:lorem) { 'Lorem ipsum' }
  let(:written_post) { create(:post) }

  describe 'COMMENT #create' do
    it 'creates should require logged-in user' do
      expect do
        post :create, params: { comment: { content: lorem,
                                           post_id: written_post.id } }
      end.to_not change(Comment, :count)
    end
  end
end
