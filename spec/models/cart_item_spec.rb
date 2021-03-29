require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Cartモデルとのアソシエーション' do
      let(:target) { :cart }

      it 'Cartとの関連付けはbelongs_toであること' do
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
    it '有効なCartItemモデル' do
      cart_item = FactoryBot.build(:cart_item)
      expect(cart_item).to be_valid
    end
    
    it 'quantityが負の数を持つのは無効であること' do
      cart_item = FactoryBot.build(:cart_item, quantity: -10)
      cart_item.valid?
      expect(cart_item.errors.of_kind?(:quantity, :greater_than_or_equal_to)).to be_truthy
    end
  end
end
