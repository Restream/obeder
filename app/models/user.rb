class User < ApplicationRecord
  extend Enumerize
  include UserRepository
  include AASM

  has_many :user_menus, dependent: :destroy
  has_many :menus, through: :user_menus

  acts_as_paranoid

  validates :name, :role, :email, presence: true
  validates :email, uniqueness: true
  validates :email, email: true, if: 'role.cook?'
  validates :email, restream_email: true, unless: 'role.cook?'
  validates_confirmation_of :password

  has_secure_password validations: false

  enumerize :role, in: [:admin, :cook, :user], default: :user

  aasm do
    state :inactive, initial: true
    state :active

    event :activate do
      transitions from: [:active, :inactive], to: :active
    end

    event :deactivate do
      transitions from: [:active, :inactive], to: :inactive
    end
  end
end
