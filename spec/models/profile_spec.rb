require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'バリデーション' do
    it '有効なプロフィールモデル作成' do
      profile = FactoryBot.build(:profile)
      expect(profile).to be_valid
    end

    it 'user_idがない場合、無効である' do
      profile = FactoryBot.build(:profile, user_id: nil)
      profile.valid?
      expect(profile.errors.of_kind?(:user, :blank)).to be_truthy
    end

    it '名前が20文字以下の場合、有効である' do
      profile = FactoryBot.build(:profile, name: 'a' * 20)
      expect(profile).to be_valid
    end

    it '名前が20文字より多い場合、無効である' do
      profile = FactoryBot.build(:profile, name: 'a' * 21)
      profile.valid?
      expect(profile.errors.of_kind?(:name, :too_long)).to be_truthy
    end
  end

  it 'userが作成されると、profileが生成される' do
    expect { FactoryBot.create(:user) }.to change { Profile.count }.by(1)
  end

  it 'userを削除すると、userと紐づくprofileも削除される' do
    user = FactoryBot.create(:user)
    expect { user.destroy }.to change { Profile.count }.by(-1)
  end
end
