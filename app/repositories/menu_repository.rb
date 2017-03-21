module MenuRepository
  extend ActiveSupport::Concern
  
  included do
    scope :for_date, -> (date) { where(date: date) }
    scope :for_date_range, -> (date, offset) { where(date: (date - offset.days)..(date + offset.days)).order(:date) }
    scope :except_date, -> (date) { where.not(date: date) }
    scope :ready, -> { where(ready: true) }
  end
end