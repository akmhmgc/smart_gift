require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Orderモデルとのアソシエーション' do
      let(:target) { :order }

      it 'Orderとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'Productモデルとのアソシエーション' do
      let(:target) { :product }

      it 'Productとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end

  describe 'バリデーション' do
    it '有効なOrderItemモデル' do
      order_item = FactoryBot.build(:order_item)
      expect(order_item).to be_valid
    end
    
    it 'quantityが負の数を持つのは無効であること' do
      order_item = FactoryBot.build(:order_item, quantity: -10)
      order_item.valid?
      expect(order_item.errors.of_kind?(:quantity, :greater_than_or_equal_to)).to be_truthy
    end
  end
end
