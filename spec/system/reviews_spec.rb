require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
  let(:current_product) { FactoryBot.create(:product) }
  # let(:current_product) { FactoryBot.create(:product) }

  context 'ユーザーがログインしているとき' do
    let(:login_user) { current_user }

    before do
      login_test_user(login_user)
      visit product_path(current_product)
    end

    fdescribe 'レビュー投稿' do
      it 'レビュー投稿フォームが表示されること' do
        expect(page).to have_content 'レビュー投稿'
        expect(page).to have_selector('input', id: 'review_title')
      end

      it 'レビューを投稿できること', js: true do
        fill_in 'review_title', with: 'review_title'
        fill_in 'review_body', with: 'review_body'
        select '★★★★★', from: 'review[stars]'
        click_button '投稿'

        expect(page).to have_content 'レビューが投稿されました'
        expect(page).to have_content 'review_title'
        expect(page).to have_content 'review_body'
        expect(page).to have_selector 'div', style: '--rating: 5;'
      end
    end

    describe 'レビュー編集・削除' do
      before 'レビュー投稿' do
        fill_in 'review_title', with: 'review_title'
        fill_in 'review_body', with: 'review_body'
        click_button '投稿'
        current_product.reload
      end

      describe 'レビュー編集', js: true do
        it '自分のレビューには編集ボタンが表示され、編集可能である ' do
          expect(page).to have_link '編集'
          click_on '編集'
          fill_in 'review_title', with: 'edited_review_title'
          fill_in 'review_body', with: 'edited_review_body'
          select '★★★', from: 'review[stars]'
          click_button '更新'
          sleep 0.5
          expect(page).to have_content 'レビューが更新されました'
          expect(page).to have_selector 'span', text: 'review_title'
          expect(page).to have_selector 'p', text: 'review_body'
          expect(page).to have_selector 'div', style: '--rating: 3;'
        end
      end

      describe 'レビュー削除', js: true do
        it '自分のレビューには削除ボタンが表示され、削除可能である ' do
          expect(page).to have_link '削除'
          click_on '削除'
          expect  do
            expect(page.accept_confirm).to eq 'レビューを削除しますか？'
            expect(page).to have_content '削除に成功しました'
            sleep 1
          end.to change(current_product.reviews, :count).by(-1)
        end
      end
    end

    describe '他のユーザーのレビュー編集・削除', js: true do
      let(:other_user) { FactoryBot.create(:user, email: 'other_user_test@test.com') }
      let!(:other_profile) { FactoryBot.create(:profile, user_id: other_user.id) }

      before 'レビュー投稿' do
        fill_in 'review_title', with: 'review_title'
        fill_in 'review_body', with: 'review_body'
        click_button '投稿'
        current_product.reload
        find(".tham-box").click
        click_link "ログアウト"

        login_test_user(other_user)
        visit product_path(current_product)
      end

      it '他のユーザーのレビューは表示されるが削除・編集ボタンが表示されない' do
        expect(page).to have_content 'review_title'
        expect(page).to have_content 'review_body'
        expect(page).not_to have_link '編集', exact: true
      end

    end
  end

  context 'ユーザーがログインしていない時' do
    describe 'レビュー投稿' do
      it '投稿フォームが表示されないこと' do
        visit product_path(current_product)
        expect(page).not_to have_content 'レビュー投稿'
      end
    end
  end
end
