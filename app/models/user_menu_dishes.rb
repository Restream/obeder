class UserMenuDish < ApplicationRecord
  belongs_to :dishes
  belongs_to :user_menus
end
