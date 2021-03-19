FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "サンプルアイテム_#{n}" }
    price { 100 }
    description { "サンプルアイテムです" }
    stock { 100 }
    publish { true }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/cake.jpg')) }
    association :store
    association :category
  end
end
