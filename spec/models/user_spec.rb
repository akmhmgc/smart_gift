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
      it 'Userが削除されたらReviewも削除されること' do
        create(:review, user_id:user.id)
        expect { user.destroy }.to change(Review, :count).by(-1)
      end
    end

    context 'Like' do
      let(:target) { :likes }
      it { expect(association.macro).to eq :has_many }
      it { expect(association.class_name).to eq 'Like' }
      it 'Userが削除されたらLikeも削除されること' do
        create(:like, user_id:user.id)
        expect { user.destroy }.to change(Like, :count).by(-1)
      end
    end

    context 'Order' do
      describe "order" do
        let(:target) { :orders }
        it { expect(association.macro).to eq :has_many }
        it { expect(association.class_name).to eq 'Order' }
        it 'Userが削除されたらOrderも削除されること' do
          create(:like, user_id:user.id)
          expect { user.destroy }.to change(Like, :count).by(-1)
        end
      end

      describe "cart" do
      end
    end

    # context 'Notification' do
    #   let(:target) { :likes }
    #   it { expect(association.macro).to eq :has_many }
    #   it { expect(association.class_name).to eq 'Like' }
    #   it 'Userが削除されたらLikeも削除されること' do
    #     create(:like, user_id:user.id)
    #     expect { user.destroy }.to change(Like, :count).by(-1)
    #   end
    # end

    # context 'Order' do
    #   let(:target) { :review }
    #   let(:user) { create(:user) }
    #   let!(:review) {create(:review, user_id:user.id) }
    #   it { expect(association.macro).to eq :has_one }
    #   it { expect(association.class_name).to eq 'Profile' }
    #   it 'Userが削除されたらProfileも削除されること' do
    #     expect { user.destroy }.to change(Profile, :count).by(-1)
    #   end
    # end

    # before do
    #   @user = FactoryBot.create(:user)
    #   @user.create_profile!(name: @user.username)
    #   product = FactoryBot.create(:product)
    #   Like.create(user_id: @user.id, product_id: product.id)
    #   Review.create(user_id: @user.id, product_id: product.id, title: 'title', body: 'body')
    #   sleep 0.1
    # end

    # let(:association) do
    #   described_class.reflect_on_association(target)
    # end

    # context 'Profileモデルとのアソシエーション' do
    #   before do
    #     FactoryBot.create(:profile, user_id:@user.id)
    #   end
    #   let(:target) { :profile }

    #   it 'Profileとの関連付けはhas_oneであること' do
    #     expect(association.macro).to eq :has_one
    #   end

    #   it 'Userが削除されたらProfileも削除されること' do
    #     expect { @user.destroy }.to change(Profile, :count).by(-1)
    #   end
    # end

    # context "Reviewモデルとのアソシエーション" do
    #   let(:target) { :reviews }

    #   it "Reviewとの関連付けはhas_manyであること" do
    #     expect(association.macro).to eq :has_many
    #   end

    #   it "Userが削除されたらReviewも削除されること" do
    #     expect { @user.destroy }.to change(Review, :count).by(-1)
    #   end
    # end

    # context 'Likeモデルとのアソシエーション' do
    #   let(:target) { :likes }
    #   it 'Likeとの関連付けはhas_manyであること' do
    #     expect(association.macro).to eq :has_many
    #   end

    #   it 'Userが削除されたらLikeも削除されること' do
    #     expect { @user.destroy }.to change(Like, :count).by(-1)
    #   end
    # end

    # context 'Orderモデルとのアソシエーション' do
    #   before do
    #     FactoryBot.create(:order, user_id:@user.id)
    #   end
    #   let(:target) { :order}
    #   it 'Cartとの関連付けはhas_manyであること' do
    #     expect(association.macro).to eq :has_one
    #   end

    #   it 'Userが削除されたらOrderも削除されること' do
    #     expect { @user.destroy }.to change(Order, :count).by(-1)
    #   end
    # end
  end
end
