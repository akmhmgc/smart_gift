FactoryBot.define do
  factory :review do
    title { 'title' }
    body { 'body' }
    association :user
    association :product
  end
end
