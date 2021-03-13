require 'rails_helper'

RSpec.describe Like, type: :model do
  it '有効なLikeモデル作成' do
    like = FactoryBot.create(:like)
    expect(like).to be_valid
  end

  it '有効なuserモデル' do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    FactoryBot.create(:like, user_id: user.id, product_id: product.id)
    like = FactoryBot.build(:like, user_id: user.id, product_id: product.id)
    # like = Like.new(user_id: user.id,
    #                 product_id: product.id)
  end
end
