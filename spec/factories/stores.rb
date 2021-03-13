FactoryBot.define do
  factory :store do
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'foobar' }
  end
end
