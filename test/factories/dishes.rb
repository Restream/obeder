FactoryGirl.define do
  factory :dish do
    name
    description

    trait :salatik do
      dish_type :salatik
    end
  end
end
