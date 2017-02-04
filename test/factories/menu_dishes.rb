FactoryGirl.define do
  factory :menu_dish do
    after(:build) do |menu_dish|
      menu_dish.dish = create :dish
    end
  end
end
