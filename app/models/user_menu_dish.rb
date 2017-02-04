class UserMenuDish < ApplicationRecord
  belongs_to :dish
  belongs_to :user_menu
end
