FactoryBot.define do
  factory :like do
    user_id { 100 }
    product_id { 100 }
    association :user
    association :product
  end
end
