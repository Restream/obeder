class UserMenuVoteType < ActiveType::Object
  attribute :voted, :boolean
  attribute :dish_id, :integer
  attribute :user_menu_id, :integer

  validates :voted, inclusion: { in: [true, false] }
  validates :dish_id, presence: true
  validates :user_menu_id, presence: true
  validate :check_user_menu_exists

  def check_user_menu_exists
    @user_menu ||= UserMenu.find_by(id: user_menu_id)
    errors.add(:user_menu_id, :invalid) if @user_menu.nil?
  end

  def voteable
    @voteable ||= MenuDish.find_by(menu_id: @user_menu.menu_id, dish_id: dish_id)
  end
end
