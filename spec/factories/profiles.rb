FactoryBot.define do
  factory :profile do
    name { 'テストユーザー' }
    association :user
  end
end
