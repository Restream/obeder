class MenuDish < ApplicationRecord
  belongs_to :dish
  belongs_to :menu
end
