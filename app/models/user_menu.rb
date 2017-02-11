class UserMenu < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :user_menu_dishes
  has_many :dishes, through: :user_menu_dishes

  scope :for_date, ->(date) { where(menu: Menu.where(date: date)) }
  scope :for_week, -> { where(menu: Menu.where('date >= ? AND date < ?', Date.current, Date.current.end_of_week)) }
end
