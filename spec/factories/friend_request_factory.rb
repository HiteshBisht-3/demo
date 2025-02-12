FactoryBot.define do
  factory :friend_request do
    sender { create(:user) }
    receiver { create(:user) }
    status { [:pending, :accepted, :rejected].sample }
  end
end
