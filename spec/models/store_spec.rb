require 'rails_helper'

RSpec.describe Store, type: :model do
  store = FactoryBot.build(:store)
  it 'storeインスタンスが有効であること' do
    expect(store).to be_valid
  end

  it 'メールアドレスがない場合無効である' do
    store = FactoryBot.build(:store, email: '')
    store.valid?
    expect(store.errors.of_kind?(:email, :blank)).to be_truthy
  end

  it 'メールアドレスが不正な場合、無効である' do
    store = FactoryBot.build(:store, email: 'test.test.com')
    store.valid?
    expect(store.errors.of_kind?(:email, :invalid)).to be_truthy
  end

  it 'パスワードがない場合、無効である' do
    store = FactoryBot.build(:store, password: '')
    store.valid?
    expect(store.errors.of_kind?(:password, :blank)).to be_truthy
  end

  it 'パスワードが短すぎ場合、無効である' do
    store = FactoryBot.build(:user, password: 'a')
    store.valid?
    expect(store.errors.of_kind?(:password, :too_short)).to be_truthy
  end

  it '同じアドレスのインスタンスは無効である' do
    store_1 = FactoryBot.create(:store, email: 'sample@sample.com')
    store_2 = FactoryBot.build(:store, email: 'sample@sample.com')
    store_2.valid?
    expect(store_2.errors.of_kind?(:email, :taken)).to be_truthy
  end

  describe '各モデルとのアソシエーション' do
    before do
      @store = FactoryBot.create(:store)
      FactoryBot.create(:product, store_id: @store.id)
      sleep 0.1
    end

    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Productモデルとのアソシエーション' do
      let(:target) { :products }

      it 'Profileとの関連付けはhas_oneであること' do
        expect(association.macro).to eq :has_many
      end

      it 'Userが削除されたらPrductも削除されること' do
        expect { @store.destroy }.to change(Product, :count).by(-1)
      end
    end
  end
end
