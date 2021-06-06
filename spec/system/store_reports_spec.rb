require 'rails_helper'

RSpec.describe "StoreReports", type: :system do
  let!(:giftcard) { create(:giftcard, user_id: current_user.id) }
  let(:current_store) { FactoryBot.create(:store) }
  let(:current_product) { FactoryBot.create(:product, price: 500, name: 'current_product', store_id: current_store.id) }
  let(:other_product) { FactoryBot.create(:product, price: 100, name: 'other_product') }

  let!(:order_item_1) do
    create(:order_item, order_id: giftcard.id, product_id: current_product.id, quantity: 5, price: current_product.price, store_id: current_store.id,
                        product_name: current_product.name)
  end
  let!(:order_item_2) { create(:order_item, order_id: giftcard.id, product_id: other_product.id, quantity: 10, price: other_product.price) }
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }

  it "自店舗の商品に関するレポートのみ表示" do
    login_test_store(current_store)
    expect(page).to have_selector 'p', text: '￥2500'

    # 売り上げランキング商品
    expect(find(".ranking")).to have_content 'current_product'
    expect(find(".ranking")).not_to have_content 'other_product'

    # 販売履歴一覧
    expect(page).to have_selector 'th', text: '¥2500'
    expect(page).to have_selector 'th', text: 'テスト太郎'

    find(".order_link").click
    sleep 0.5
    expect(current_path).to eq dashboard_order_path(giftcard.id)
    expect(page).to have_content 'current_product'
    expect(page).to have_content '5個'

    expect(page).not_to have_content 'other_product'
  end

  it "購入者アカウントが削除されても注文履歴は残り、「削除されたユーザー」となる"  do
    current_user.destroy
    login_test_store(current_store)
    expect(page).to have_selector 'th', text: '¥2500'
    expect(page).to have_selector 'th', text: '削除されたユーザー'

    find(".order_link").click
    sleep 0.5
    expect(page).to have_content 'current_product'
    expect(page).to have_content '削除されたユーザー'
  end
end
