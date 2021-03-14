require 'rails_helper'

RSpec.describe Like, type: :model do
  it "有効なカラムを持つこと" do
      expect(FactoryBot.build_stubbed(:like)).to be_valid
    end
  
    context "likeモデルのバリデーション" do
      it "user_idがなければ無効な状態であること" do
        like = FactoryBot.build(:like, user_id: nil)
        like.valid?
        expect(like.errors.of_kind?(:user_id, :blank)).to be_truthy
      end
  
      it "product_idがなければ無効な状態であること" do
        like = FactoryBot.build(:like, product_id: nil)
        like.valid?
        expect(like.errors.of_kind?(:product_id, :blank)).to be_truthy
      end
    end
  
    describe "各モデルとのアソシエーション" do
      let(:association) do
        described_class.reflect_on_association(target)
      end
  
      context "Userモデルとのアソシエーション" do
        let(:target) { :user }
  
        it "Userとの関連付けはbelongs_toであること" do
          expect(association.macro).to eq :belongs_to
        end
      end
  
      context "Productモデルとのアソシエーション" do
        let(:target) { :product }
  
        it "Productとの関連付けはbelongs_toであること" do
          expect(association.macro).to eq :belongs_to
        end
      end
    end
end