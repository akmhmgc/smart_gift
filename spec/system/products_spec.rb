require 'rails_helper'

RSpec.describe 'Products', type: :system do
  let!(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let!(:current_profile) { FactoryBot.create(:profile, user_id: current_user.id) }
  let!(:other_user) { FactoryBot.create(:user, email: 'other_user_test@test.com') }
  let!(:other_profile) { FactoryBot.create(:profile, name: 'テスト三郎', user_id: other_user.id) }

  describe '店舗がログインしている場合' do
    before '店舗のログイン' do
    end

    it '新しい商品を作成可能' do
    end

    context '現在の店舗≠商品の店舗' do
      before do
      end

      it '商品の編集が出来ない' do
      end
    end

    context '現在の店舗=商品の店舗' do
      before do
      end

      it '商品の編集ができる' do
      end

      it '商品の削除ができる' do
      end
    end

  end

  describe '店舗がログインしていない場合' do
    before do
    end

    it 'ダッシュボードの商品ページにログイン出来ない' do
    end
  end
end
