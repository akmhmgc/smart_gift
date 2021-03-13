FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "サンプルアイテム_#{n}" }
    price { 100 }
    association :store
    association :category
  end
end
