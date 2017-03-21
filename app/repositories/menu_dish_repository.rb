module MenuDishRepository
  extend ActiveSupport::Concern
  
  included do
    scope :default, -> { where(default: true) }
  end
end
