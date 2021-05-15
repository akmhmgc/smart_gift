require 'rails_helper'

RSpec.describe "ReceiveGiftcards", type: :system do
  let!(:giftcard) { create(:giftcard) }
  let!(:product) { create(:product, name: "テストアイテム") }
  let!(:order_item) { create(:order_item, order_id: giftcard.id, product_id: product.id, quantity: 5, product_name: product.name) }

  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
  it "ログインすると一度限り受け取り可能", js: true do
    visit giftcard_path(giftcard)
    expect(page).to have_content 'テストアイテム'
    expect(page).to have_content '5個'
    click_button 'ギフトを受け取る'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'アカウント登録もしくはログインしてください。'

    login_test_user(current_user)
    sleep 0.5
    visit giftcard_path(giftcard)
    click_button 'ギフトを受け取る'
    sleep 0.5
    expect(page).to have_content 'ギフトの受け取りに成功しました'
    expect(page).to have_content 'テストアイテム'
    expect(page).to have_content '5個'

    # ２度目の受け取りは出来ない
    visit giftcard_path(giftcard)
    click_button 'ギフトを受け取る'
    expect(page).to have_content '既にギフトは受け取られています'
  end
end
