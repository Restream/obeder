class UserMenu < ApplicationRecord
  include UserMenuRepository

  belongs_to :menu
  belongs_to :user

  has_many :user_menu_dishes, dependent: :destroy
  has_many :dishes, through: :user_menu_dishes

  validates :editable, inclusion: { in: [true] }
end
