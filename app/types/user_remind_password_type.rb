class UserRemindPasswordType < ActiveType::Object
  attribute :email, :string
  validates :email, presence: true, email: true

  def user
    User.find_by(email: email.mb_chars.downcase)
  end
end
