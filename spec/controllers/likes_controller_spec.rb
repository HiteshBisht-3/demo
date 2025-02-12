require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'when the user has not liked the post' do
      it 'creates a like' do
        expect {
          post :create, params: { post_id: post.id }
        }.to change { post.likes.count }.by(1)
      end
    end

    context 'when the user has already liked the post' do
      before { post.likes.create(user: user) }

      it 'destroys the like' do
        expect {
          post :create, params: { post_id: post.id }
        }.to change { post.likes.count }.by(-1)
      end
    end

    it 'redirects back to the previous page' do
      post :create, params: { post_id: post.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE #destroy' do
    before { post.likes.create(user: user) }

    it 'destroys the like' do
      expect {
        delete :destroy, params: { post_id: post.id }
      }.to change { post.likes.count }.by(-1)
    end

    it 'redirects to the post show page' do
      delete :destroy, params: { post_id: post.id }
      expect(response).to redirect_to(post)
    end
  end
end
