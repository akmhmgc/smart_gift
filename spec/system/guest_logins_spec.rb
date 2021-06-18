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
end
