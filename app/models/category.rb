class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: true }
  has_many :products, dependent: :destroy
  has_ancestry
end
