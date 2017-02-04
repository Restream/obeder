class Menu < ApplicationRecord
  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes
  has_many :user_menus
  has_many :users, through: :user_menus

  scope :for_week, -> { where('date >= ? AND date < ?', Date.today, Date.today.end_of_week) }
end
