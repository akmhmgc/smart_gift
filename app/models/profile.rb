class Profile < ApplicationRecord
  include ImageModule
  belongs_to :user
  validates :name, presence: true, length: { maximum: 20 }
  validates :money, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 999_999 }

  def add_money(money)
    increment(:money, money)
    save
  end
end
