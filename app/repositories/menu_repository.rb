module MenuRepository
  extend ActiveSupport::Concern

  DATE_OFFSET = 2
  
  included do
    scope :for_date, -> (date) { where(date: date) }
    scope :current_menu, -> (date) { for_date(date).first || create(date: date) }
    scope :for_date_range, -> (date, offset) { where(date: (date - offset.days)..(date + offset.days)).order(:date) }
    scope :except_date, -> (date) { where.not(date: date) }
    scope :ready, -> { where(ready: true) }
    scope :closest_days_menus, -> (date) { includes(menu_dishes: :dish).for_date_range(date, DATE_OFFSET).except_date(date) }
  end
end
