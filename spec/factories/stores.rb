FactoryBot.define do
  factory :store do
    storename { 'test_store' }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'foobar' }
    confirmed_at { Time.zone.now }
  end
end
