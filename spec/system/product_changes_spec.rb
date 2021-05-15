require 'rails_helper'

RSpec.describe "ProductChanges", type: :system do
  let!(:giftcard) { create(:giftcard, user_id: current_user.id) }
  let(:current_store) { FactoryBot.create(:store) }
  let(:current_product) { FactoryBot.create(:product, price: 500, name: 'current_product', store_id: current_store.id) }
  let(:other_product) { FactoryBot.create(:product, price: 100, name: 'other_product') }

  let!(:order_item_1) { create(:order_item, order_id: giftcard.id, product_id: current_product.id, quantity: 5, price: current_product.price) }
  let!(:order_item_2) { create(:order_item, order_id: giftcard.id, product_id: other_product.id, quantity: 10, price: other_product.price) }
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }

  sahred_examples_for '注文済みアイテムの表示' do
    it "店舗の販売履歴の商品名、価格は変わらず表示されていること" do
    end

    it "ユーザーの注文履歴の商品名、価格は変わらず表示されていること" do
    end

    it "受け取りギフトカードの商品名、価格は変わらず表示されていること" do
    end
  end

  describe "元の商品が削除された場合" do
    it_behaves_like '注文済みアイテムの表示'
  end

  describe "元の商品が変更された場合" do
    it_behaves_like '注文済みアイテムの表示'
  end
end
