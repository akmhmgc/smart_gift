require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  describe 'ユーザーが商品に対してコメントといいねを行う', js: true do
    let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
    let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
    let(:current_store) { FactoryBot.create(:store) }
    let!(:current_product) { FactoryBot.create(:product, store_id: current_store.id) }

    before 'コメントといいね'  do
      # いいね
      login_test_user(current_user)
      visit products_path
      find('#like_heart').click

      # レビュー
      visit product_path(current_product)
      fill_in 'review_title', with: 'review_title'
      fill_in 'review_body', with: 'review_body'
      click_button '投稿'
      find('.tham-box').click
      sleep 1.5
      find('a', text: 'ログアウト').click

      # 店舗ページへのログイン
      login_test_store(current_store)
    end

    it '通知ページにコメントといいねが表示され、通知を確認するとマークが消える' do
      expect(page).to have_selector 'span', id: 'notification_mark'
      visit notifications_path
      expect(page).to have_content "テスト太郎さんが サンプルアイテム_1 にいいねしました。"
      expect(page).to have_content "テスト太郎さんが サンプルアイテム_1 にレビューを投稿しました"
      expect(page).to have_content 'review_title'
      expect(page).to have_content 'review_body'
      expect(page).not_to have_selector 'span', id: 'notification_mark'
    end
  end
end
