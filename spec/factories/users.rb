FactoryBot.define do
  factory :user do
    username { 'user_taro' }
    sequence(:email) { |n| "test_user_#{n}@example.com" }
    password { 'foobar' }
    confirmed_at { Time.zone.now }
  end
end
