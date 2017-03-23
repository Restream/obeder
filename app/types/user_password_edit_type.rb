class UserPasswordEditType < User
  attribute :password, :string
  attribute :password_confirmation, :string

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
