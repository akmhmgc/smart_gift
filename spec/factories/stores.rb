FactoryBot.define do
  factory :store do
    sequence(:storename) { |n| "test_store_#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'foobar' }
    confirmed_at { Time.zone.now }
  end
end
