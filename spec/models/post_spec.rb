require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:file) }
    it { should validate_length_of(:caption).is_at_most(2200) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_one_attached(:file) }
  end

  describe 'like_count method' do
    it 'returns the correct like count' do
      post = create(:post)
      create(:like, post: post)
      create(:like, post: post)
      expect(post.like_count).to eq(2)
    end
  end
end
