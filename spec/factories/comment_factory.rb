FactoryBot.define do
  factory :comment do
    content { 'sample comment' }
    post
    user
  end
end
