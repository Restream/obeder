class Dish < ApplicationRecord
  DEFAULT_DISH_TYPE = 'soup'.freeze

  extend Enumerize
  include DishRepository

  has_many :menu_dishes
  has_many :menus, through: :menu_dishes
  has_many :user_menu_dishes
  has_many :user_menus, through: :user_menu_dishes

  validates :name, :dish_type, presence: true

  mount_uploader :image, DishImageUploader

  enumerize :dish_type, in: [:soup, :main_dish, :side_dish, :salad, :separate_dish]
end
