FactoryBot.define do
  factory :profile do
    name { 'テスト太郎' }
    money { 10_000 }
    association :user
    after(:build) do |post|
      post.image.attach(io: File.open('spec/fixtures/image/user_default.png'), filename: 'user_default.png', content_type: 'image/png')
    end
  end
end
