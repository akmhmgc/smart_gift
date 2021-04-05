class Store < ApplicationRecord
  include CommonModule

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one_attached :image
  has_many :products, dependent: :destroy

  #   notification
  has_many :notifications, dependent: :destroy

  validates :description, length: { maximum: 500 }, presence: true
  validates :storename, length: { maximum: 20 }, presence: true
  # image validation
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }
end
