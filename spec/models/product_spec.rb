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
    product = FactoryBot.build(:product, name: 'a' * 31)
    product.valid?
    expect(product.errors.of_kind?(:name, :too_long)).to be_truthy
  end
  it '同一storeが同じ名前のproductを持つのは無効' do
    store = FactoryBot.create(:store)
    create(:product, store_id: store.id, name: "サンプルストア")
    product  = build(:product, store_id: store.id, name: "サンプルストア")
    product.valid?
    expect(product.errors.of_kind?(:name, :taken)).to be_truthy
  end
  it '異なるstoreが同じ名前のproductを持つのは有効' do
    store = FactoryBot.create(:store)
    create(:product, store_id: store.id, name: "サンプルストア")
    product  = build(:product, name: "サンプルストア")
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

    context "Order_itemsモデルとのアソシエーション" do
      let(:target) { :order_items }

      it "OrderItemsとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Productが削除されたらOrderItemsも削除されること" do
        create(:order_item, product_id: @product.id)
        expect { @product.destroy }.to change(OrderItem, :count).by(-1)
      end
    end

    context "Notificationsモデルとのアソシエーション" do
      let(:target) { :notifications }

      it "OrderItemsとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Productが削除されたらOrderItemsも削除されること" do
        create(:notification, product_id: @product.id)
        expect { @product.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end

  describe 'メソッドテスト' do
    let(:product) { create(:product) }
    let(:user) { create(:user) }
    describe "#create_notification_like!" do
      it "いいねしていいない時、通知レコードを作成" do
        expect { product.create_notification_like!(user) }.to change(Notification, :count).by(1)
      end

      it "既にいいねしている場合は通知レコードを作成しない" do
        product.create_notification_like!(user)
        expect { product.create_notification_like!(user) }.to change(Notification, :count).by(0)
      end
    end
  end
end
