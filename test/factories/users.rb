FactoryGirl.define do
  factory :user do
    name
    email 'username@restream.rt.ru'
    description

    factory :user_with_user_menus do
      transient do
        posts_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:user_menu_with_user_menu_dishes, evaluator.posts_count, user: user)
      end
    end

  end
end
