class MenuPublishReadinessValidator < ActiveModel::Validator
  def validate(record)
    errors = record.errors
    dishes = record.dishes
    errors.add(:dishes, :less_than_two_soups) unless more_than?(dishes, :soup, 1)
    errors.add(:dishes, :less_than_two_salads) unless more_than?(dishes, :salad, 1)

    main_and_separate_dishes = dishes.where(dish_type: :main_dish)
                              .or(dishes.where(dish_type: :main_dish))
                              .size

    errors.add(:dishes, :less_than_two_main_dishes) unless main_and_separate_dishes > 1

    has_defaults = (exists_default?(dishes, :soup) && exists_default?(dishes, :salad)) ||
                   (exists_default?(dishes, :main_dish) && exists_default?(dishes, :side_dish)) ||
                    exists_default?(dishes, :separate_dish)

    errors.add(:dishes, :no_defaults) unless has_defaults
    errors.add(:dishes, :main_to_side_dishes_mismatch) unless quantity_matches?(dishes, :main_dish, :side_dish)
  end

  def more_than?(dishes, dish_type, required_number)
    dishes.where(dish_type: dish_type).size > required_number
  end

  def exists_default?(dishes, dish_type)
    dishes.where(dish_type: dish_type).any? { |dish| dish.menu_dishes.exists?(default: true) }
  end

  def quantity_matches?(dishes, dish_one, dish_two)
    dishes.where(dish_type: dish_one).size == dishes.where(dish_type: dish_two).size
  end
end
