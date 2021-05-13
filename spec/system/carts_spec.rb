require 'rails_helper'

RSpec.describe 'Carts', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
  let(:current_product) { FactoryBot.create(:product, price: 500, name: 'test_product') }
  describe 'カート機能' do
    context 'ユーザーがログインしている時' do
      before 'ログインして商品を追加' do
        login_test_user(current_user)
        visit product_path(current_product)
        select '4', from: 'quantity'
        click_button 'カートに入れる'
      end
      it '商品をカートに追加出来ること' do
        expect(page).to have_content '商品が追加されました'
        expect(page).to have_content 'test_product'
        expect(page).to have_content '500'
        expect(page).to have_field('quantity', with: '4')
        expect(page).to have_content '合計 2000円'
      end
      it 'カートにある商品数を更新出来ること', js: true do
        fill_in 'quantity', with: '10'
        click_button '更新'
        sleep 0.5
        expect(page).to have_content 'カート内のギフトが更新されました'
        expect(page).to have_field('quantity', with: '10')
        expect(page).to have_content '合計 5000円'
      end
      it '商品ページから同じアイテムを追加するとカート画面のアイテム数が更新される' do
        visit product_path(current_product)
        select '6', from: 'quantity'
        click_button 'カートに入れる'

        expect(page).to have_content '商品が追加されました'
        expect(page).to have_content 'test_product'
        expect(page).to have_content '500'
        expect(page).to have_field('quantity', with: '10')
        expect(page).to have_content '合計 5000円'
      end
      it 'カートにある商品を削除出来ること', js: true do
        click_button '削除'

        expect(page.accept_confirm).to eq '商品を削除しますか？'
        expect(page).to have_content 'カート内のギフトが削除されました'
        sleep 0.5
        expect(page).not_to have_content 'test_product'
        expect(page).to have_content '合計 0円'
      end

      fit 'カートに追加した商品を購入し、ギフトカードを自分で受け取ると受け取り済みギフトにに追加されていること', js: true do
        fill_in 'message_box', with: 'message'
        fill_in 'sender_name', with: 'tarou'
        click_button 'ギフトカードの作成'

        expect(page).to have_content 'ギフトカードが完成しました'
        expect(page).to have_content 'message'
        expect(page).to have_content 'tarouさんからのメッセージ'
        click_button '決済する'

        expect(page).to have_content 'ギフトカードの購入が完了しました'
        click_button '自分で受け取る'

        expect(page).to have_content 'ギフトの受け取りに成功しました'
        expect(page).to have_content 'message'
        expect(page).to have_content 'tarouさんからのメッセージ'
        expect(page).to have_content 'test_product'
        expect(page).to have_content '4個'

        # 注文履歴にも表示される
      end
    end

    context 'ユーザーがログインしていない時' do
      before 'ログインして商品ページに移動' do
        visit product_path(current_product)
      end
      it '商品をカートに追加しようとするとログインページにリダイレクトする' do
        select '4', from: 'quantity'
        click_button 'カートに入れる'

        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end
