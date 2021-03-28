FactoryBot.define do
  factory :cart_item do
    quantity { 1 }
    product { nil }
    cart { nil }
  end
end
