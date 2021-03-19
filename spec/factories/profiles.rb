FactoryBot.define do
  factory :profile do
    name { 'テスト太郎' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/user_default.png')) }
    association :user
  end
end
