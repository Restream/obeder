FactoryGirl.define do
  factory :dish do
    name
    description
    image { generate :image }
    dish_type :soup

    trait :salad do
      dish_type :salad
    end
  end
end
