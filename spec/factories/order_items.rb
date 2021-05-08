FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    price { 100 }
    association :product
    association :order
  end
end
