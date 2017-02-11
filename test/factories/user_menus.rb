FactoryGirl.define do
  factory :user_menu do
    description
    user
    menu

    trait :with_dish do
      after(:create) do |user_menu|
        create :user_menu_dish, user_menu: user_menu
      end
    end

    trait :with_dishes do
      after(:create) do |user_menu|
        create_list :user_menu_dish, 3, user_menu: user_menu
      end
    end
  end
end
