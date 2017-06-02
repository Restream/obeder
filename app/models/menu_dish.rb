class MenuDish < ApplicationRecord
  include MenuDishRepository

  belongs_to :dish
  belongs_to :menu

  validates :dish, presence: true
  validates :menu, presence: true
end
