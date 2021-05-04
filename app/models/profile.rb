class Profile < ApplicationRecord
  include AddDefaultImageModule
  belongs_to :user
  validates :name, presence: true, length: { maximum: 20 }
  validates :money, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 999_999 }

  def add_money(money)
    return false unless money.to_s =~ /\A([1-9][0-9]*)\z/ && money.to_i.positive?

    increment(:money, money.to_i)
    save!
  end
end
