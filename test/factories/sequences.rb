FactoryGirl.define do
  sequence :string, aliases: [:name, :description] do |n|
    "string-#{n}"
  end

  sequence :email do |n|
    "example-#{n}@mail.com"
  end

  sequence :integer do |n|
    n
  end

  sequence :float do |n|
    n.to_f + 0.5
  end

  sequence :date do |n|
    Date.today + n.days
  end
end
