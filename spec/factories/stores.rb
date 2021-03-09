FactoryBot.define do
  factory :store do
    storename { 'サンプル商店' }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'foobar' }
  end
end
