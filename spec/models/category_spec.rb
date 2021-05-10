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
    create(:category, name:'サンプルカテゴリ')
    category = build(:category, name:'サンプルカテゴリ')
    category.valid?
    expect(category.errors.of_kind?(:name, :taken)).to be_truthy
  end

  describe '各モデルとのアソシエーション' do
    before do
      @category = FactoryBot.create(:category)
      FactoryBot.create(:product, category_id: @category.id)
      sleep 0.1
    end

    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Productモデルとのアソシエーション' do
      let(:target) { :products }

      it 'Profileとの関連付けはhas_oneであること' do
        expect(association.macro).to eq :has_many
      end

      it 'Categoryが削除されるとPrductは削除されること' do
        expect { @category.destroy }.to change(Product, :count).by(-1)
      end
    end
  end
end
