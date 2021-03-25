FactoryBot.define do
  factory :review do
    title { 'title' }
    body { 'body' }
    stars { 3 }
    association :user
    association :product
  end
end
