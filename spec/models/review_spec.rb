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

  describe "callback" do
    before do
      @product = create(:product)
      sleep 0.5
      create_list(:review, 3, product_id: @product.id, stars: 3)
      @review = create(:review, product_id: @product.id, stars: 1)
    end

    it "レビューが追加されると商品の星の平均と評価の数が変わる" do
      create(:review, product_id: @product.id, stars: 5)
      @product.reload
      expect(@product.reviews_count).to eq 5
      expect(@product.stars_average).to eq @product.reviews.average(:stars)
    end

    it "レビューが削除されると商品の星の平均と評価の数が変わる" do
      @review.destroy
      @product.reload
      expect(@product.reviews_count).to eq 3
      expect(@product.stars_average).to eq @product.reviews.average(:stars)
    end
  end
end
