FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "サンプルアイテム_#{n}" }
    price { 100 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/cake.jpg')) }
    association :store
    association :category
  end
end
