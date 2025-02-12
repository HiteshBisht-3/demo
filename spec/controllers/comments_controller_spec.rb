require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:comment) { create(:comment, post: post, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns the comments of the post to @comments' do
      get :index, params: { post_id: post.id }
      expect(assigns(:comments)).to include(comment)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new comment and redirects back to the post' do
        expect {
          post :create, params: { post_id: post.id, comment: { content: 'Nice post!' } }
        }.to change { post.comments.count }.by(1)

        expect(response).to redirect_to(post)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a comment and redirects to the post' do
        expect {
          post :create, params: { post_id: post.id, comment: { content: '' } }
        }.to_not change { post.comments.count }

        expect(response).to redirect_to(post)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the comment and redirects back to the root path' do
      comment = create(:comment, post: post, user: user)

      expect {
        delete :destroy, params: { post_id: post.id, id: comment.id }
      }.to change { post.comments.count }.by(-1)

      expect(response).to redirect_to(root_path)
    end
  end
end
