FactoryBot.define do
  factory :profile do
    name { 'テストユーザー' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/user_default.png')) }
    association :user
  end
end
