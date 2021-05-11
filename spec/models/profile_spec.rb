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

    it '名前が存在しない場合、無効である' do
      profile = FactoryBot.build(:profile, name: '')
      profile.valid?
      expect(profile.errors.of_kind?(:name, :blank)).to be_truthy
    end

    it '名前が20文字より多い場合、無効である' do
      profile = FactoryBot.build(:profile, name: 'a' * 21)
      profile.valid?
      expect(profile.errors.of_kind?(:name, :too_long)).to be_truthy
    end

    it '所持金がマイナスの場合無効である' do
      profile = FactoryBot.build(:profile, money: -100)
      profile.valid?
      expect(profile.errors.of_kind?(:money, :greater_than_or_equal_to)).to be_truthy
    end

    it '所持金が小数点を含む数の場合無効である' do
      profile = FactoryBot.build(:profile, money: 100.5)
      profile.valid?
      expect(profile.errors.of_kind?(:money, :not_an_integer)).to be_truthy
    end
  end

  it 'userを削除すると、userと紐づくprofileも削除される' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:profile, user_id: user.id)
    expect { user.destroy }.to change { Profile.count }.by(-1)
  end

  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userモデルとのアソシエーション' do
      let(:target) { :user }

      it 'Userとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end

  describe "メソッドのテスト" do
    let(:profile) { create(:profile) }
    describe "add_money" do
      it "正の値を渡すとuserのmoneyが増える" do
        expect { profile.add_money(100) }.to change { profile.money }.by(100)
      end

      it "負の値を渡すとuserのmoneyは変化しない" do
        expect { profile.add_money(-100) }.to change { profile.money }.by(0)
      end
    end
  end
end
