FactoryBot.define do
  factory :like do
    association :user
    association :product
  end
end
