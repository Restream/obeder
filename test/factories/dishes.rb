FactoryGirl.define do
  factory :dish do
    name
    description

    trait :salad do
      dish_type :salad
    end
  end
end
