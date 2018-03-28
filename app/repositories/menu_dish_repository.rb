module MenuDishRepository
  extend ActiveSupport::Concern

  included do
    scope :default, -> { where(default: true) }
    scope :with_dish, -> { includes(:dish) }
    scope :ordered_by_dish, -> { order('dishes.dish_type, dishes.id') }
  end
end
