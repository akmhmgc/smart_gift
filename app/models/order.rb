class Order < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  default_scope -> { order(updated_at: :desc) }
  scope :with_product_images, -> { preload(order_items: { product: { image_attachment: :blob } }) }
  scope :belongs_to_store, lambda { |store|
                             eager_load([:order_items], [{ user: :profile }]).where(order_items: { store_id: store.id })
                           }

  def to_param
    public_uid
  end

  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy, inverse_of: :order
  validates :order_items, length: { minimum: 1, message: 'を1つ以上選択してください'  }, on: :cart_check
  validates :sender_name, presence: true, length: { maximum: 20 }, on: :cart_check
  validates :message, presence: true, length: { maximum: 300 }, on: :cart_check
  validate :total_cannnot_over_users_money, on: :cart_check

  def total_price
    order_items.sum("order_items.price*quantity")
  end

  def total_price_for_store(store)
    order_items.where("store_id =?", store.id).sum("order_items.price*quantity")
  end

  private

  def total_cannnot_over_users_money
    errors.add(:order_items, "が利用可能金額を超えています。プロフィール画面よりチャージまたはアイテムを減らしてください。") if total_price > user.profile.money
  end
end
