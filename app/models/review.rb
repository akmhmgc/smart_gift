class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # notification
  has_one :notification, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :stars, presence: true, numericality: { in: 1..5 }

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 140 }
end