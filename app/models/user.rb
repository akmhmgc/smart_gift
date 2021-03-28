class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :products, through: :likes
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :cart, dependent: :destroy

  validates :username, presence: true, length: { maximum: 20 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

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
    products.likes.exists?(product_id: product.id)
  end

  # private

  # def profile_setup
  #   build_profile
  #   profile.update(name: 'ユーザー')
  #   profile.image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'user.png')
  # end
end
