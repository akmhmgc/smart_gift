FactoryBot.define do
  factory :order do
    association :user
    sender_name { 'test_taro' }
    message { 'hello world' }
    received { true }
  end

  factory :giftcard, class: 'Order' do
    association :user
    sender_name { 'test_taro' }
    message { 'hello world' }
    received { true }
    recipient_id { nil }
  end
end
