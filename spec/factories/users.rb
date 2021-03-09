FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_user_#{n}@example.com" }
    password { 'foobar' }
    confirmed_at { Time.zone.now }
  end
end
