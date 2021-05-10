require 'rails_helper'

RSpec.fdescribe User, type: :model do
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

  it 'ニックネームがない場合、無効である' do
    user = FactoryBot.build(:user, username: '')
    user.valid?
    expect(user.errors.of_kind?(:username, :blank)).to be_truthy
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

  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:user) { create(:user) }

    context 'Profile' do
      let(:target) { :profile }
      it { expect(association.macro).to eq :has_one }
      it { expect(association.class_name).to eq 'Profile' }
      it 'Userが削除されたらProfileも削除されること' do
        create(:profile, user_id:user.id)
        expect { user.destroy }.to change(Profile, :count).by(-1)
      end
    end

    context 'Reviews' do
      let(:target) { :reviews }
      it { expect(association.macro).to eq :has_many }
      it { expect(association.class_name).to eq 'Review' }
      pending 'Userが削除されたらReviewも削除されること' do
        create(:review, user_id:user.id)
        expect { user.destroy }.to change(Review, :count).by(-1)
      end
    end

    context 'Like' do
      let(:target) { :likes }
      it { expect(association.macro).to eq :has_many }
      it { expect(association.class_name).to eq 'Like' }
      pending 'Userが削除されたらLikeも削除されること' do
        create(:like, user_id:user.id)
        expect { user.destroy }.to change(Like, :count).by(-1)
      end
    end

    context 'Order' do
      let(:target) { :orders }
      it { expect(association.macro).to eq :has_many }
      it { expect(association.class_name).to eq 'Order' }
      pending 'Userが削除されたらOrderも削除されること' do
        create(:order, user_id:user.id)
        sleep 0.4
        expect { user.destroy }.to change(Order, :count).by(-1)
      end
    end

    context 'Notification' do
      let(:target) { :notifications }
      it { expect(association.macro).to eq :has_many }
      it { expect(association.class_name).to eq 'Notification' }
      pending 'Userが削除されたらNotificationも削除されること' do
        create(:notification, user_id:user.id)
        expect { user.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end

  describe "メソッドのテスト" do
    let(:user) { create(:user) }
    let(:product) { create(:product) }
    describe "#like" do
      it "商品をお気に入りに追加する" do
        expect { user.like(product) }.to change(Like.where(user_id:user.id, product_id:product.id), :count).by(1)
      end

      it "既にお気に入りしている商品をいいねするとエラーが発生する" do
        user.like(product)
        expect { user.like(product) }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    describe "like?" do
      it "既にお気に入りしている商品の場合trueを返す" do
        user.like(product)
        expect(user.like?(product)).to be_truthy
      end

      it "お気に入りしていない商品の場合falseを返す" do
        expect(user.like?(product)).to be_falsey
      end
    end

    describe "unlike" do
      it "商品をお気に入りから外す" do
        user.like product
        expect { user.unlike(product) }.to change(Like.where(user_id:user.id, product_id:product.id), :count).by(-1)
      end
    end

    describe "#self.guest" do
      it "ゲストユーザーが存在しない場合新規で作成される" do
        expect { User.guest }.to change(User.where(email: 'guest_user@example.com'), :count).by(1)
      end

      it "ゲストユーザーが存在する場合は作成しない" do
        create(:user, email: 'guest_user@example.com')
        expect { User.guest }.to change(User.where(email: 'guest_user@example.com'), :count).by(0)
      end
    end

    describe "#receive_giftcard?" do
      before do
        @giftcard = create(:order,received:true,recipient_id:nil)
        create(:order_item, order_id: @giftcard.id)
      end
      it "ギフトカードが既に受け取られている場合はfalseを返す" do
        user.receive_giftcard?(@giftcard)
        expect { user.receive_giftcard?(@giftcard) }.to change(Order.where(recipient_id:user.id, received:true), :count).by(0)
      end

      it "ギフトカードが受け取られていない場合はtrueを返し、recipient_idが変更される" do
        expect { user.receive_giftcard?(@giftcard) }.to change(Order.where(recipient_id:user.id, received:true), :count).by(1)
      end
    end
  end
end
