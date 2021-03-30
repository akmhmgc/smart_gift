FactoryBot.define do
  factory :order do
    association :user
    sender_name { 'test_taro' }
    message { 'hello world' }
    recieved { false }
  end
end
