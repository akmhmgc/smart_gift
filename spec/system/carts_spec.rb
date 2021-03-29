require 'rails_helper'

RSpec.describe 'Carts', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
  let(:current_product) { FactoryBot.create(:product, price: 500, name: 'test_product') }
  describe 'カート機能' do
    context 'ユーザーがログインしている時' do
      before 'ログインして商品ページに移動' do
        login_test_user(current_user)
        visit product_path(current_product)
      end
      it '商品をカートに追加出来ること' do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        expect(page).to have_content '商品が追加されました'
        expect(page).to have_content 'test_product'
        expect(page).to have_content '500'
        expect(page).to have_field('quantity', with: '4')
        expect(page).to have_content '合計：2000円'
      end
      it 'カートにある商品数を更新出来ること' do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        fill_in 'quantity', with: '10'
        click_button '更新'

        expect(page).to have_content 'カート内のギフトが更新されました'
        expect(page).to have_field('quantity', with: '10')
        expect(page).to have_content '合計：5000円'
      end
      it 'カートにある商品を削除出来ること', js: true do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        click_button '削除'

        expect(page.accept_confirm).to eq '商品を削除しますか？'
        expect(page).to have_content 'カート内のギフトが削除されました'
        sleep 0.5
        expect(page).not_to have_content 'test_product'
        expect(page).to have_content '合計：0円'
      end
    end

    context 'ユーザーがログインしていない時' do
      before 'ログインして商品ページに移動' do
        visit product_path(current_product)
      end
      it '商品をカートに追加出来ること' do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        expect(page).to have_content '商品が追加されました'
        expect(page).to have_content 'test_product'
        expect(page).to have_content '500'
        expect(page).to have_field('quantity', with: '4')
        expect(page).to have_content '合計：2000円'
      end
      it 'カートにある商品数を更新出来ること' do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        fill_in 'quantity', with: '10'
        click_button '更新'

        expect(page).to have_content 'カート内のギフトが更新されました'
        expect(page).to have_field('quantity', with: '10')
        expect(page).to have_content '合計：5000円'
      end
      it 'カートにある商品を削除出来ること', js: true do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        click_button '削除'

        expect(page.accept_confirm).to eq '商品を削除しますか？'
        expect(page).to have_content 'カート内のギフトが削除されました'
        sleep 0.5
        expect(page).not_to have_content 'test_product'
        expect(page).to have_content '合計：0円'
      end
    end
  end
end
