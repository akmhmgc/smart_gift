require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '各モデルとのアソシエーション' do
    let(:order) { create(:order) }
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'OrderItemモデルとのアソシエーション' do
      let(:target) { :order_items }

      it 'OrderItemとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'Userモデルとのアソシエーション' do
      let(:target) { :user }

      it 'OrderItemとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
