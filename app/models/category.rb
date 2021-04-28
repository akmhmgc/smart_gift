class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: true }
  has_many :products, dependent: :destroy
  has_ancestry

  def name_for_search
    ancestry? ? name.insert(0, '-') : name
  end
end
