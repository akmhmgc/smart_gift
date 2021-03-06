FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "サンプルアイテム_#{n}" }
    price { 100 }
    description { 'サンプルアイテムです' }
    association :store
    association :category
    # image { FactoryHelpers.upload_file(Rails.root.join('spec/factories/images/user_default.png','image/png', true)) }
    after(:build) do |post|
      post.image.attach(io: File.open('spec/fixtures/image/user_default.png'), filename: 'user_default.png', content_type: 'image/png')
    end
  end

  factory :search_a, class: 'Product' do
    name { 'hoge' }
    price { 500 }
    description { 'サンプルアイテムです' }
    association :store
    association :category
    after(:build) do |post|
      post.image.attach(io: File.open('spec/fixtures/image/user_default.png'), filename: 'user_default.png', content_type: 'image/png')
    end
  end

  factory :search_b, class: 'Product' do
    name { 'piyo' }
    price { 2000 }
    description { 'サンプルアイテムです' }
    association :store
    association :category
    after(:build) do |post|
      post.image.attach(io: File.open('spec/fixtures/image/user_default.png'), filename: 'user_default.png', content_type: 'image/png')
    end
  end
end
