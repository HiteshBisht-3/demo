require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let!(:user1) { create(:user, username: 'john_doe') }
  let!(:user2) { create(:user, username: 'jane_smith') }
  let!(:user3) { create(:user, username: 'alice_jones') }

  describe 'GET #index' do
    context 'when a search query is provided' do
      it 'returns users that match the query' do
        get :index, params: { query: 'john' }
        expect(assigns(:users)).to match_array([user1])
      end

      it 'returns users whose usernames partially match the query' do
        get :index, params: { query: 'jane' }
        expect(assigns(:users)).to match_array([user2])
      end
    end

    context 'when no search query is provided' do
      it 'returns an empty array' do
        get :index, params: { query: '' }
        expect(assigns(:users)).to eq([])
      end
    end

    context 'when the query does not match any usernames' do
      it 'returns an empty array' do
        get :index, params: { query: 'nonexistent' }
        expect(assigns(:users)).to eq([])
      end
    end
  end
end
