require "rails_helper"
RSpec.describe PostsController, type: :controller do
  describe ' controller test cases ' do
    let(:user1) { FactoryBot.create :user }

    describe '#show' do
      it 'should return the user with given id' do
        get :show, params: { id: user1.id }
        expect(assigns(:user)).to eql(user1)
      end
    end
  end
end
