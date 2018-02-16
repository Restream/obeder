class MenuDishVoteType < ActiveType::Object
  attribute :voted, :boolean
  attribute :dish_id, :integer
  attribute :user_menu_id, :integer

  validates :voted, inclusion: { in: [true, false] }
  validates :dish_id, presence: true
  validates :user_menu_id, presence: true

  def voteable
    user_menu = UserMenu.find_by(id: user_menu_id)
    return if user_menu.blank?

    MenuDish.find_by(menu_id: user_menu.menu_id, dish_id: dish_id)
  end
end
