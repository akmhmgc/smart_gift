require 'rails_helper'

RSpec.describe 'Products', type: :system do
  let(:current_store) { FactoryBot.create(:store, email: 'store_test@test.com') }
  let(:current_product) { FactoryBot.create(:product, store_id: current_store.id) }
  let(:other_store) { FactoryBot.create(:store, email: 'other_store_test@test.com') }
  let(:other_product) { FactoryBot.create(:product, store_id: other_store.id) }

  describe '店舗がログインしている場合' do
    before '店舗のログイン' do
      login_test_store(login_store)
    end
    
    before 'カテゴリの作成' do
      sweets = Category.create!(name: 'お菓子')
      sweets.children.create!({ name: 'ケーキ' })
      sweets.children.create!({ name: 'プリン' })
    end

    let(:login_store) { current_store }

    it '新しい商品を作成可能' do
      find(".tham-box").click
      sleep 1
      click_link "販売アイテム"
      click_on '商品登録'
      expect(current_path).to eq new_dashboard_product_path
      find("#image_field").attach_file(Rails.root.join('spec/fixtures/image/cake.jpg'))
      fill_in 'product_name', with: 'テスト商品'
      fill_in 'product_price', with: 3000
      select 'ケーキ', from: 'product[category_id]'
      fill_in 'product_description', with: 'テスト商品です。'
      click_on '登録する'

      expect(current_path).to eq dashboard_products_path
      expect(page).to have_selector "img[src$='cake.jpg']"
      expect(page).to have_selector 'p', text: 'テスト商品'
      expect(page).to have_selector 'p', text: '3000'
    end

    context '現在の店舗≠商品の店舗' do
      it '商品の編集が出来ない' do
        visit edit_dashboard_product_path(other_product)
        sleep 0.5
        expect(current_path).to eq dashboard_products_path
        expect(page).to have_content '無効なURLです'
      end
    end

    context '現在の店舗=商品の店舗' do
      fit '商品の編集ができる' do
        visit edit_dashboard_product_path(current_product)
        fill_in 'product_name', with: 'テスト商品2'
        fill_in 'product_price', with: 999
        fill_in 'product_description', with: 'テスト商品2です。'
        find("#image_field").attach_file(Rails.root.join('spec/fixtures/image/pudding.jpg'))
        click_on '更新する'

        expect(current_path).to eq dashboard_products_path
        expect(page).to have_selector 'p', text: 'テスト商品2'
        expect(page).to have_selector 'p', text: '999'
        expect(page).to have_selector "img[src$='pudding.jpg']"
      end

      it '商品の削除ができる', js: true do
        visit edit_dashboard_product_path(current_product)
        click_on "削除する"
        expect{
          expect(page.accept_confirm).to eq "商品を削除しますか？"
          expect(page).to have_content "削除に成功しました"
          sleep 1
          }. to change(current_store.products, :count).by(-1)
      end
    end
  end

  describe '店舗がログインしていない場合' do
    it 'ダッシュボードの商品ページにログイン出来ない' do
      visit dashboard_products_path
      expect(current_path).to eq new_store_session_path
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end
  end
end
