class User < ApplicationRecord
  # プロフィールも作成
  after_create { self.build_profile }

  # like
  has_many :likes, dependent: :destroy
  has_many :products, through: :likes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :profile, dependent: :destroy

  # 商品をお気に入りに入れる
  def like(product)
    products << product
  end

  # 商品のお気に入りの解除
  def unlike(product)
    likes.find_by(product_id: product.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def like?(product)
    products.include?(product)
  end
end
