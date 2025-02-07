require "rails_helper"
RSpec.describe Post, type: :model do
  describe "validations" do
    it { should validate_presence_of(:file) }
    it { should validate_length_of(:caption).is_at_most(2200) }
  end
  describe "association" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_one_attached(:file) }
  end
end
