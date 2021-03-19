require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  let!(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
  let!(:other_user) { FactoryBot.create(:user, email: 'other_user_test@test.com') }
  let!(:other_profile) { FactoryBot.create(:profile, name: 'テスト三郎', user_id: other_user.id) }
  describe 'ユーザーが新規登録した場合' do
    before 'ユーザーの新規登録' do
      visit root_path
      click_link '新規会員登録', match: :first
      fill_in 'ユーザーネーム(ニックネーム)', with: 'テスト太郎'
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_button '新規登録する'
      @user = User.last
      @profile = Profile.last
    end

    it '紐づいたProfileモデルが作成される' do
      expect(@user.id).to eq @profile.user_id
      expect(@user.username).to eq @profile.name
      expect(@profile.user.email).to eq 'test@test.com'
    end
  end

  describe 'ユーザーがログインしているとき' do
    let(:login_user) { current_user }

    before do
      login_test_user(login_user)
    end

    context '現在のユーザー=プロフィール画面のユーザーの場合' do
      before do
        visit profiles_path(current_profile.user)
      end

      it 'プロフィール画面が表示される' do
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'p', text: 'テスト太郎'
      end

      it '編集画面にアクセスでき、プロフィールを編集できる' do
        click_on '編集する'
        expect(current_path).to eq edit_profiles_path(current_profile.user)
        attach_file 'image', "#{Rails.root}/spec/fixtures/image/cake.jpg"
        fill_in 'name', with: 'テスト次郎'
        click_on '更新'
        expect(current_path).to eq profiles_path(current_profile.user)
        expect(page).to have_selector "img[src$='cake.jpg']"
        expect(page).to have_selector 'p', text: 'テスト次郎'
      end
    end

    context '現在のユーザー≠プロフィール画面のユーザーの場合' do
      before do
        visit profiles_path(other_profile.user)
      end

      it 'プロフィール画面が表示されるが、編集できないこと' do
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'p', text: 'テスト三郎'

        visit edit_profiles_path(other_user)
        expect(current_path).to eq profiles_path(other_user)
        expect(page).to have_content '無効なURLです'
      end
    end
  end

  describe 'ユーザーがログインしていないとき' do
    before do
      visit profiles_path(other_profile.user)
    end

    it 'プロフィール画面が表示されるが、編集できないこと' do
      expect(page).to have_selector 'img'
      expect(page).to have_selector 'p', text: 'テスト三郎'
      expect(page).not_to have_selector 'a', text: '編集する'

      visit edit_profiles_path(other_user)
      expect(current_path).to eq new_user_session_path
    end
  end
end
