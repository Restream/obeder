class MenuDish < ApplicationRecord
  belongs_to :dish
  belongs_to :menu

  scope :default, -> { where(default: true) }
end
