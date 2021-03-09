class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :store
  belongs_to :review, optional: true
  belongs_to :product, optional: true
end
