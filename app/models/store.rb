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
  validates :storename, length: { maximum: 20 }, presence: true, uniqueness: { case_sensitive: true }
  
  # image validation
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }

  def self.guest
    find_or_create_by!(email: 'guest_store@example.com') do |store|
      store.password = SecureRandom.urlsafe_base64
      store.storename = "ゲストストア"
      store.description = "ゲストストアです"
      store.confirmed_at = Time.zone.now
    end
  end
end
