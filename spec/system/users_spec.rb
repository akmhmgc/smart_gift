require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let(:current_store) { FactoryBot.create(:store, email: 'store_test@test.com') }
  describe '新規登録機能' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    def extract_confirmation_url(mail)
      body = mail.body.encoded
      body[/http[^"]+/]
    end

    it 'パスワードが正しく２回入力されていないとエラーになる' do
      visit root_path
      expect(page).to have_http_status :ok

      click_link '新規会員登録', match: :first
      fill_in 'メールアドレス', with: 'test_name'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'testteset'
      click_button '新規登録する'
      expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
    end

    it 'ユーザー登録後、ログアウトとログインが正しく行われる' do
      visit root_path
      expect(page).to have_http_status :ok

      click_link '新規会員登録', match: :first
      fill_in 'ユーザーネーム(ニックネーム)', with: 'テスト太郎'
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      expect { click_button '新規登録する' }.to change { ActionMailer::Base.deliveries.size }.by(1)
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

      mail = ActionMailer::Base.deliveries.last
      url = extract_confirmation_url(mail)
      visit url
      expect(page).to have_content 'メールアドレスが確認できました。'

      click_on('ログアウト')
      expect(page).to have_content 'ログアウトしました。'

      click_link 'ログイン', match: :first
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'password'
      click_on 'ログインする'
      expect(page).to have_content 'ログインしました。'
    end
  end

  describe '店舗がログインしている場合' do
    it 'ユーザーがログアウトしないと店舗はログイン出来ない' do
      # 店舗のログイン
      visit root_path
      click_link '店舗としてログイン'
      fill_in 'メールアドレス', with: current_store.email
      fill_in 'パスワード', with: 'foobar'
      click_on 'ログインする'
      expect(page).to have_content 'ログインしました。'

      # ユーザーのログインページに移動するとリダイレクトされる
      visit new_user_session_path
      expect(current_path).to eq store_path(current_store)
      expect(page).to have_content '店舗として既にログインしています。'

      # 店舗がログアウトするとユーザーはログイン可能
      current_user.create_profile!(name:"test_user")
      click_link 'ログアウト'

      click_link 'ログイン', match: :first
      fill_in 'メールアドレス', with: current_user.email
      fill_in 'パスワード', with: 'foobar'
      click_on 'ログインする'
      expect(page).to have_content 'ログインしました。'
    end
  end
end