require 'rails_helper'

RSpec.describe Category, type: :model do
  it '有効なcategoryモデル作成' do
    category = FactoryBot.build(:category)
    expect(category).to be_valid
  end

  it 'nameが空の場合、無効である' do
    category = FactoryBot.build(:category, name: '')
    category.valid?
    expect(category.errors.of_kind?(:name, :blank)).to be_truthy
  end

  it 'nameが長すぎる場合、無効である' do
    category = FactoryBot.build(:category, name: 'a' * 21)
    category.valid?
    expect(category.errors.of_kind?(:name, :too_long)).to be_truthy
  end

  it '同じnameのカテゴリは無効である' do
    category_1 = FactoryBot.create(:category, name:'サンプルカテゴリ')
    category_2 = FactoryBot.build(:category, name:'サンプルカテゴリ')
    category_2.valid?
    expect(category_2.errors.of_kind?(:name, :taken)).to be_truthy
  end
end
