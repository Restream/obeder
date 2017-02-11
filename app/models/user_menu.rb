class UserMenu < ApplicationRecord
  belongs_to :menu
  belongs_to :user

  has_many :user_menu_dishes
  has_many :dishes, through: :user_menu_dishes

  scope :em, -> { where(user: User.where(neem: false)) }
  scope :for_date, ->(date) { where(menu: Menu.where(date: date)) }
  scope :for_week, -> { where(menu: Menu.where('date >= ? AND date < ?', Date.current, Date.current + 7.days)) }
  scope :by_user_name, -> { order('users.name') }
  scope :with_users, -> { includes(:user) }
  scope :with_dishes, -> { includes(:dishes) }
end
