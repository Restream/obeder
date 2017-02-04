class User < ApplicationRecord
  has_many :user_menus
  has_many :menus, through: :user_menus
end
