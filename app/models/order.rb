class Order < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  default_scope -> { order(updated_at: :desc) }

  def to_param
    public_uid
  end

  belongs_to :user
  has_many :order_items, -> { includes :product }, dependent: :destroy, inverse_of: :order
  validates :order_items, length: { minimum: 1, message: 'を1つ以上選択してください'  }, on: :update
  validates :sender_name, presence: true, length: { maximum: 20 }, on: :update
  validates :message, presence: true, length: { maximum: 300 }, on: :update
end
