class User < ApplicationRecord
  extend Enumerize

  has_many :user_menus, dependent: :destroy
  has_many :menus, through: :user_menus

  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true, restream_email: true
  validates_confirmation_of :password

  has_secure_password validations: false

  enumerize :role, in: [:admin, :cook, :user], default: :user

end
