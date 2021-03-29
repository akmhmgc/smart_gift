require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '各モデルとのアソシエーション' do
    before do
      @cart = FactoryBot.create(:cart)
      FactoryBot.create(:cart_item, cart_id:@cart.id)
    end
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'CartItemモデルとのアソシエーション' do
      let(:target) { :cart_items }

      it 'CartItemとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end

      it 'Cartが削除されたらLikeも削除されること' do
        expect { @cart.destroy }.to change(CartItem, :count).by(-1)
      end
    end
  end
end
