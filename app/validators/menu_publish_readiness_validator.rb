class MenuPublishReadinessValidator < ActiveModel::Validator
  def validate(record)
    errors = record.errors
    dishes = record.dishes

    errors.add(:dishes, :less_than_two_soups) if less_than?(dishes, :soup, 2)
    errors.add(:dishes, :less_than_two_salads) if less_than?(dishes, :salad, 2)
    errors.add(:dishes, :less_than_two_main_dishes) if main_and_separate_dishes_count(dishes) < 2
    errors.add(:dishes, :incorrect_defaults) unless correct_defaults?(record)
    errors.add(:dishes, :main_to_side_dishes_mismatch) unless quantity_matches?(dishes, :main_dish, :side_dish)
  end

  private

  def less_than?(dishes, dish_type, required_number)
    dishes.where(dish_type: dish_type).size < required_number
  end

  def single_default?(record, dish_type)
    record.dishes.where(dish_type: dish_type).one? do |dish|
      dish.menu_dishes.where(menu: record).exists?(default: true)
    end
  end

  def quantity_matches?(dishes, dish_one, dish_two)
    dishes.where(dish_type: dish_one).size == dishes.where(dish_type: dish_two).size
  end

  def main_and_separate_dishes_count(dishes)
    dishes.where(dish_type: :main_dish)
      .or(dishes.where(dish_type: :separate_dish))
      .size
  end

  def correct_defaults?(record)
    single_default?(record, :soup) &&
      single_default?(record, :salad) &&
      (single_default?(record, :main_dish) && single_default?(record, :side_dish) || single_default?(record, :separate_dish))
  end
end
