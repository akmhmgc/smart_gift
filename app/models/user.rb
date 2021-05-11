class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :products, through: :likes
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_one :cart,  -> { where received: false }, class_name: 'Order', inverse_of: :user
  has_many :orders,  -> { where received: true }, class_name: 'Order', inverse_of: :user
  has_many :giftcards, class_name: 'Order', foreign_key: "recipient_id"
  validates :username, presence: true, length: { maximum: 20 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]

  def like(product)
    products << product
  end

  def unlike(product)
    likes.find_by(product_id: product.id).destroy
  end

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
        user.username = data['username'] if user.username.blank?
        user.provider = data['provider'] if data['provider'] && user.provider.blank?
        user.uid = data['uid'] if data['uid'] && user.uid.blank?
        user.skip_confirmation!
      end
    end
  end

  def pay
    ActiveRecord::Base.transaction do
      cart.attributes = { received: true }
      cart.save!(context: :cart_check)
      cart.order_items.touch_all
      profile.decrement(:money, cart.total_price)
      profile.save!
    end
  end

  def receive_giftcard?(giftcard)
    return false unless giftcard.recipient_id.nil?

    giftcard.attributes = { recipient_id: id, received_at: Time.zone.now }
    giftcard.save!(touch: false)
  end
end
