require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:association) do
    described_class.reflect_on_association(target)
  end

  context "Reviewモデルとのアソシエーション" do
    let(:target) { :review }
    it "Reviewとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "Userモデルとのアソシエーション" do
    let(:target) { :user }

    it "Userとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "Storeモデルとのアソシエーション" do
    let(:target) { :store }

    it "Storeとの関連付けはbelongs_toであること" do
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
