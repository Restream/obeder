class Dish < ApplicationRecord
  has_many :menu_dishes
  has_many :menus, through: :menu_dishes
  has_many :user_menu_dishes
  has_many :user_menus, through: :user_menu_dishes
end
