class MenuDishVoteType < MenuDish
  validates :voted, inclusion: { in: [true, false] }
end
