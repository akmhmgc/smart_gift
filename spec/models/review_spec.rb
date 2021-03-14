require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーション' do
    it 'titleが存在しない場合無効であること' do
      review = FactoryBot.build(:review, title: '')
      review.valid?
      expect(review.errors.of_kind?(:title, :blank)).to be_truthy
    end
    it 'titleが31文字以上の場合無効であること' do
      review = FactoryBot.build(:review, title: 'a' * 31)
      review.valid?
      expect(review.errors.of_kind?(:title, :too_long)).to be_truthy
    end
    it 'bodyが存在しない場合無効であること' do
      review = FactoryBot.build(:review, body: '')
      review.valid?
      expect(review.errors.of_kind?(:body, :blank)).to be_truthy
    end
    it 'bodyが141文字以上の場合無効であること' do
      review = FactoryBot.build(:review, body: 'a' * 141)
      review.valid?
      expect(review.errors.of_kind?(:body, :too_long)).to be_truthy
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
