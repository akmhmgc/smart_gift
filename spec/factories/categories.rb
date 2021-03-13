FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "カテゴリ_#{n}" }
  end
end
