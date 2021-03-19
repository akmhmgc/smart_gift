require 'rails_helper'

RSpec.describe Product, type: :model do
  it '有効なプロダクト' do
    product = FactoryBot.build(:product)
    expect(product).to be_valid
  end
  it '名前が存在しないと無効' do
    product = FactoryBot.build(:product, name: '')
    product.valid?
    expect(product.errors.of_kind?(:name, :blank)).to be_truthy
  end
  it '名前が長すぎると無効' do
    product = FactoryBot.build(:product, name: 'a' * 21)
    product.valid?
    expect(product.errors.of_kind?(:name, :too_long)).to be_truthy
  end
  it '同一storeが同じ名前のproductを持つのは無効' do
    category = FactoryBot.create(:category)
    store = FactoryBot.create(:store)
    store.products.create!(name: 'サンプルアイテム',
                           price: 300,
                           category_id: category.id)
    product = store.products.build(name: 'サンプルアイテム',
                                   price: 300,
                                   category_id: category.id)
    product.valid?
    expect(product.errors.of_kind?(:name, :taken)).to be_truthy
  end
  it '異なるstoreが同じ名前のproductを持つのは有効' do
    category = FactoryBot.create(:category)
    store_1 = FactoryBot.create(:store)
    store_1.products.create!(name: 'サンプルアイテム',
                             price: 300,
                             category_id: category.id)
    store_2 = FactoryBot.create(:store)
    product = store_2.products.build(name: 'サンプルアイテム',
                                     price: 300,
                                     category_id: category.id)
    expect(product).to be_valid
  end

  it '値段が存在しないのは無効' do
    product = FactoryBot.build(:product, price: '')
    product.valid?
    expect(product.errors.of_kind?(:price, :blank)).to be_truthy
  end
  it '値段が低すぎるのは無効' do
    product = FactoryBot.build(:product, price: -100)
    product.valid?
    expect(product.errors.of_kind?(:price, :greater_than_or_equal_to)).to be_truthy
  end
  it '値段が高すぎるのは無効' do
    product = FactoryBot.build(:product, price: 100_000_000)
    product.valid?
    expect(product.errors.of_kind?(:price, :less_than_or_equal_to)).to be_truthy
  end
  it '値段に小数点が含まれるのも無効' do
    product = FactoryBot.build(:product, price: 100.34)
    product.valid?
    expect(product.errors.of_kind?(:price, :not_an_integer)).to be_truthy
  end

  describe '各モデルとのアソシエーション' do
    before do
      @product = FactoryBot.create(:product)
      user = FactoryBot.create(:user)
      Like.create(user_id: user.id, product_id: @product.id)
      Review.create(user_id: user.id, product_id: @product.id, title: 'title', body: 'body')
      sleep 0.1
    end

    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Storeモデルとのアソシエーション' do
      let(:target) { :store }

      it 'Storeとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'Categoryモデルとのアソシエーション' do
      let(:target) { :category }

      it 'Categoryとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Likeモデルとのアソシエーション" do
      let(:target) { :likes }

      it "Likeとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Productが削除されたらLikeも削除されること" do
        expect { @product.destroy }.to change(Like, :count).by(-1)
      end
    end

    context 'Reviewモデルとのアソシエーション' do
      let(:target) { :reviews }
      it 'Reviewとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end

      it 'Productが削除されたらreviewも削除されること' do
        expect { @product.destroy }.to change(Review, :count).by(-1)
      end
    end
  end
end
