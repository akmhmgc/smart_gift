FactoryBot.define do
  factory :profile do
    name { 'テスト太郎' }
    money { 10_000 }
    image { FactoryHelpers.upload_file('spec/factories/images/user_default.png', 'image/png', true) }
    association :user
  end
end
