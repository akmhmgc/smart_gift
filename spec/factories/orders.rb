FactoryBot.define do
  factory :order do
    association :user
    sender_name { 'test_taro' }
    message { 'hello world' }
    received { true }
  end

  # factory :cart , class: 'Order' do
  #   association :user
  #   sender_name { 'test_taro' }
  #   message { 'hello world' }
  #   received { false }
  # end
end
