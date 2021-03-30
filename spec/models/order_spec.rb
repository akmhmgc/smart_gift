require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '各モデルとのアソシエーション' do
    before do
      @order = FactoryBot.create(:order)
      FactoryBot.create(:order_item, order_id:@order.id)
    end
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'OrderItemモデルとのアソシエーション' do
      let(:target) { :order_items }

      it 'OrderItemとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end

      it 'Orderが削除されたらLikeも削除されること' do
        expect { @order.destroy }.to change(OrderItem, :count).by(-1)
      end
    end
  end
end
