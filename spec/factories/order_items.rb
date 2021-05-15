FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    price { 100 }
    product_name { "test_product" }
    association :product
    association :order
    association :store
    after(:build) do |item|
      item.product_image.attach(io: File.open('spec/fixtures/image/user_default.png'), filename: 'item_default.png', content_type: 'image/png')
    end
  end
end
