FactoryBot.define do
  factory :store do
    sequence(:storename) { |n| "test_store_#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    description { 'This is a sample store' }
    password { 'foobar' }
    confirmed_at { Time.zone.now }
  end
end
