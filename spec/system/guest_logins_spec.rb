require 'rails_helper'

RSpec.fdescribe "GuestLogins", type: :system do
  describe "ゲストユーザーとしてログイン", js: true do
    let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
    let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
    let(:current_product) { FactoryBot.create(:product) }
    before do
      visit root_path
      find("a", text: "簡単ログイン").click
      expect(find('.flash', visible: false)).to have_content 'ゲストユーザーとしてログインしました'
      visit product_path(current_product)
      execute_script('window.scrollBy(0,10000)')
      fill_in 'review_title', with: 'review_title'
      fill_in 'review_body', with: 'review_body'
      select '★★★★★', from: 'review[stars]'
      click_button '投稿'
    end

    it "ゲストとしてレビュー投稿後に再度ゲストとしてログインするとレビューは消えている" do
      find("a", text: "ゲストユーザー", match: :first).click
      expect(page).to have_content 'review_title'
      find(".tham-box").click
      find("a", text: "ログアウト").click
      expect(find('.flash', visible: false)).to have_content 'ログアウトしました'
      find("a", text: "簡単ログイン").click
      find("a", text: "ゲストユーザー").click
      expect(page).to have_content 'レビューはまだ投稿されていません'
    end
  end

  # describe "ゲストストアとしてログイン", js: true do
  #   it "ゲストストアとして商品編集後に再度ゲストストアとしてログインすると商品と通知はリセットされている" do
  #   end
  # end

  # it "一度サインアップした後だとログインしてトップページに移動" do
  #   click_button '新規登録する'
  #   find(".tham-box").click
  #   sleep 1
  #   click_link "ログアウト"
  #   sleep 0.5
  #   click_link "ログイン"
  #   sleep 1
  #   click_link "Twitter"
  #   sleep 0.5
  #   expect(current_path).to eq root_path
  #   expect(page).to have_content 'Twitter アカウントによる認証に成功しました。'
  # end
end
