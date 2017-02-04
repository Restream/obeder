class DishesMenusUser < ApplicationRecord
  belongs_to :dishes
  belongs_to :menus_user
end
