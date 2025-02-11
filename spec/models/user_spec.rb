require "rails_helper"

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_length_of(:username).is_at_most(30) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_confirmation_of(:password) }
  end

  describe 'associations' do
    it { should have_one_attached(:image) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:sent_friend_requests).class_name('FriendRequest').with_foreign_key('sender_id').dependent(:destroy) }
    it { should have_many(:received_friend_requests).class_name('FriendRequest').with_foreign_key('receiver_id').dependent(:destroy) }
  end

  describe '#friends' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    
    before do
      create(:friend_request, sender: user1, receiver: user2, status: 'accepted')
      create(:friend_request, sender: user2, receiver: user3, status: 'accepted')
    end

    it 'returns friends for a user' do
      expect(user1.friends).to include(user2)
      expect(user2.friends).to include(user1, user3)
      expect(user3.friends).to include(user2)
    end
  end

  describe '.find_for_database_authentication' do
    let!(:user) { create(:user, email: 'user@example.com', phone: '1234567890') }

    context 'when login is email' do
      it 'finds user by email' do
        expect(User.find_for_database_authentication(login: 'user@example.com')).to eq(user)
      end
    end

    context 'when login is phone number' do
      it 'finds user by phone' do
        expect(User.find_for_database_authentication(login: '1234567890')).to eq(user)
      end
    end
  end

  describe '.ransackable_attributes' do
    it 'returns the expected ransackable attributes' do
      expect(User.ransackable_attributes).to eq(['username'])
    end
  end

  describe '#new_user_welcome' do
    let(:user) { build(:user) }

    it 'sends a welcome email after create' do
      expect { user.save }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end

  describe '.pick_random' do
    it 'returns a random user from the database' do
      create_list(:user, 5)
      random_user = User.pick_random
      expect(random_user).to be_a(User)
      expect(User.count).to be >= 1
    end

    it 'returns nil if there are no users' do
      expect(User.pick_random).to be_nil
    end
  end
end
