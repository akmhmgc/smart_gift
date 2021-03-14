FactoryBot.define do
  factory :notification do
    association :user
    association :store
    association :review
    association :product
  end
end
