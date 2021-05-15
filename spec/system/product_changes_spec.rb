require 'rails_helper'

RSpec.describe "ProductChanges", type: :system do
  let!(:giftcard) { create(:giftcard, user_id: current_user.id, recipient_id: current_user.id) }
  let(:current_store) { FactoryBot.create(:store) }
  let(:current_product) { FactoryBot.create(:product, price: 500, name: 'current_product', store_id: current_store.id) }
  let(:other_product) { FactoryBot.create(:product, price: 100, name: 'other_product') }

  let!(:order_item_1) do
    create(:order_item, order_id: giftcard.id, product_id: current_product.id,
                        quantity: 5, price: current_product.price, product_name: current_product.name,
                        store_id: current_product.store.id, product_image: current_product.image.blob)
  end
  let!(:order_item_2) do
    create(:order_item, order_id: giftcard.id, product_id: other_product.id,
                        quantity: 10, price: other_product.price,
                        product_name: other_product.name, store_id: other_product.store.id, product_image: other_product.image.blob)
  end
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }

  shared_examples_for '注文済みアイテムの表示' do
    it "店舗の販売履歴の商品名、価格は変わらず表示されていること" do
      login_test_store(current_store)
      expect(page).to have_selector 'th', text: '¥2500'

      find(".order_link").click
      sleep 0.5
      expect(current_path).to eq dashboard_order_path(giftcard.id)
      expect(page).to have_content 'current_product'
      expect(page).not_to have_content 'changed_product'
    end

    it "ユーザーの購入履歴・受け取り済みギフトカードの商品名、価格は変わらず表示されていること" do
      login_test_user(current_user)
      find(".tham-box").click
      sleep 1
      click_link "購入履歴"

      expect(page).not_to have_content 'changed_product'
      expect(page).to have_content 'current_product'
      expect(page).to have_content '3500円'
      expect(page).to have_content '500円'

      find(".tham-box").click
      sleep 1
      click_link "受け取ったギフトカード"
      expect(page).to have_content 'current_product'
    end
  end

  describe "元の商品が削除された場合", js: true do
    before "元の商品の削除" do
      current_product.destroy
      sleep 2
    end
    it_behaves_like '注文済みアイテムの表示'
  end

  describe "元の商品が変更された場合" do
    before "元の商品の変更" do
      current_product.update(price: 2000, name: 'changed_product')
      sleep 2
    end
    it_behaves_like '注文済みアイテムの表示'
  end
end
