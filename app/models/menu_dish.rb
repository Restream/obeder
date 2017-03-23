class MenuDish < ApplicationRecord
  include MenuDishRepository

  belongs_to :dish
  belongs_to :menu
end
