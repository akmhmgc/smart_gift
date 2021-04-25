class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :products, through: :likes
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_one :cart,  -> { where recieved: false }, class_name: 'Order', inverse_of: :user
  has_many :orders,  -> { where recieved: true }, class_name: 'Order', inverse_of: :user

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: true }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook, :twitter]

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
    likes.exists?(product_id: product.id)
  end

  def self.guest
    find_or_create_by!(email: 'guest_user@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲストユーザー"
      user.confirmed_at = Time.zone.now
    end
  end

  def self.from_omniauth(auth)
    find_by(uid: auth.uid)
  end

  def self.new_with_session(_, session)
    super.tap do |user|
      if (data = session['devise.omniauth_data'])
        user.email = data['email'] if user.email.blank?
        user.provider = data['provider'] if data['provider'] && user.provider.blank?
        user.uid = data['uid'] if data['uid'] && user.uid.blank?
        user.skip_confirmation!
      end
    end
  end

  # カート内側アイテムを購入する
  def pay
    ActiveRecord::Base.transaction do
      cart.update!(recieved: true)
      profile.decrement(:money, cart.total_price)
      profile.save!
    end
  end

  # private

  # def profile_setup
  #   build_profile
  #   profile.update(name: 'ユーザー')
  #   profile.image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'user.png')
  # end
end
