FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "サンプルアイテム_#{n}" }
    price { 100 }
    description { 'サンプルアイテムです' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/cake.jpg')) }
    association :store
    association :category
  end

  factory :search_a, class: 'Product' do
    name { 'hoge' }
    price { 500 }
    description { 'サンプルアイテムです' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/cake.jpg')) }
    association :store
    association :category
  end

  factory :search_b, class: 'Product' do
    name { 'piyo' }
    price { 1000 }
    description { 'サンプルアイテムです' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/cake.jpg')) }
    association :store
    association :category
  end
end
