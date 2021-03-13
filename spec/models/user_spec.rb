require 'rails_helper'

RSpec.describe User, type: :model do
    it '有効なユーザーモデル作成' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスがない場合、無効である' do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors.of_kind?(:email, :blank)).to be_truthy
    end

    it 'メールアドレスが不正な場合、無効である' do
      user = FactoryBot.build(:user, email: 'test.test.com')
      user.valid?
      expect(user.errors.of_kind?(:email, :invalid)).to be_truthy
    end

    it 'パスワードがない場合、無効である' do
      user = FactoryBot.build(:user, password: '')
      user.valid?
      expect(user.errors.of_kind?(:password, :blank)).to be_truthy
    end

    it 'パスワードが短すぎ場合、無効である' do
      user = FactoryBot.build(:user, password: 'a')
      user.valid?
      expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
    end

    it '同じアドレスのインスタンスは無効である' do
      user_1 = FactoryBot.create(:user, email: 'sample@sample.com')
      user_2 = FactoryBot.build(:user, email: 'sample@sample.com')
      user_2.valid?

      expect(user_2.errors.of_kind?(:email, :taken)).to be_truthy
    end
end
