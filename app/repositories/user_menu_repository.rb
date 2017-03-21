module UserMenuRepository
  extend ActiveSupport::Concern
  
  included do
    scope :em, -> { where(user: User.where(neem: false)) }
    scope :for_date, -> (date) { where(menu: Menu.where(date: date)) }
    scope :for_week, -> { where(menu: Menu.ready.where('date >= ?', Date.current)) }
    scope :by_user_name, -> { order('users.name') }
    scope :with_users, -> { includes(:user) }
    scope :with_dishes, -> { includes(:dishes) }
  end
end
