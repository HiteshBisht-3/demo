FactoryBot.define do
  factory :post do
    user
    caption { 'first post' }
    file { '' }
  end
end
