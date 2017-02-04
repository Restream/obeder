class Dish < ApplicationRecord
  has_many :dishes_menus
  has_many :menus, through: :dishes_menus
  has_many :dishes_menus_users
  has_many :menus_users, through: :dishes_menus_users
end
