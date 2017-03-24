module DishRepository
  extend ActiveSupport::Concern
  
  included do
    scope :ordered_by_name, -> { order(:name) }
  end
end
