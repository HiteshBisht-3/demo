require 'rails_helper'
RSpec.describe FriendRequest, type: :model do
  describe 'validations' do
    let!(:existing_friend_request) { create(:friend_request, sender_id: 'user1', receiver_id: 'user2') }
    it 'validates uniqueness of sender_id scoped to receiver_id' do
      new_friend_request = build(:friend_request, sender_id: 'user1', receiver_id: 'user2')

      expect(new_friend_request).to be_invalid
      expect(new_friend_request.errors[:sender_id]).to include('Friend request already sent')
    end
  end

  describe 'associations' do
    it { should belong_to(:sender).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
  end

  describe 'enum status' do
    it { should define_enum_for(:status).with_values([ :pending, :accepted, :rejected ]) }
  end
end
