class MenusUser < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :dishes_menus_users
  has_many :dishes, through: :dishes_menus_users
end
