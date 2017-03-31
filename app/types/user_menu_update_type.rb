class UserMenuUpdateType < UserMenu
  validates :editable, inclusion: { in: [true] }
end
