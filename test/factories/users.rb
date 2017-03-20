FactoryGirl.define do
  factory :user do
    name
    email { generate :email }
    password { generate :string }
    description

    trait :with_user_menu_dishes do
      after(:create) do |user|
        create_list :user_menu_with_user_menu_dishes, 3, user: user
      end
    end

    factory :user_with_user_menus, traits: [:with_user_menu_dishes]
  end
end
