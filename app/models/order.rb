class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  validates :order_items, length: { minimum: 1, message: 'を1つ以上選択してください'  }, on: :update
  validates :sender_name, presence: true, length: { maximum: 20 }, on: :update
  validates :message, presence: true, length: { maximum: 300 }, on: :update
end
