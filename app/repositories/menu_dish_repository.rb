module MenuDishRepository
  extend ActiveSupport::Concern

  included do
    scope :default, -> { where(default: true) }
    scope :with_dish, -> { includes(:dish) }
  end
end
