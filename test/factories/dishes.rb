FactoryGirl.define do
  factory :dish do
    name
    description
    dish_type { generate :string }
  end
end
