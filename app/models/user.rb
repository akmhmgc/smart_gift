class User < ApplicationRecord
  # プロフィールも作成
  after_create { self.build_profile }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :profile, dependent: :destroy
  # private

  # def make_profile
  #   self.build_profile
  # end
end
