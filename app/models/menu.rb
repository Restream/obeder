class Menu < ApplicationRecord
  has_many :dishes_menus
  has_many :dishes, through: :dishes_menus
  has_many :menus_users
  has_many :users, through: :menus_users
end
