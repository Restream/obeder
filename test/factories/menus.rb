FactoryGirl.define do
  factory :menu do
    date

    trait :approved do
      aasm_state :approved
    end

    trait :published do
      aasm_state :published
    end

    trait :with_dish do
      menu_dishes { create :menu_dish }
    end

    trait :with_dishes do
      menu_dishes { create_list :menu_dish, 3 }
    end
  end
end
