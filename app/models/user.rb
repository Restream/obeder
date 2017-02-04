class User < ApplicationRecord
  has_many :menus_users
  has_many :menus, through: :menus_users
end
