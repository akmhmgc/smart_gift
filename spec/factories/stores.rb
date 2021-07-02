FactoryBot.define do
  factory :store do
    image { FactoryHelpers.upload_file('spec/factories/images/user_default.png', 'image/png', true) }
    sequence(:storename) { |n| "test_store_#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    description { 'This is a sample store' }
    password { 'foobar' }
    confirmed_at { Time.zone.now }
  end
end
