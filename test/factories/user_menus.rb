FactoryGirl.define do
  factory :user_menu do
    user
    menu
    trait :with_dish do
      user_menu_dishes { create :user_menu_dish }
    end

    trait :with_dishes do
      user_menu_dishes { create_list :user_menu_dish, 3 }
    end
  end
end
