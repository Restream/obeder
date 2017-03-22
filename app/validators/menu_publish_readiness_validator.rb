class MenuPublishReadinessValidator < ActiveModel::Validator
  def validate(record)
    errors = record.errors[:dishes]
    errors << 'Менее двух супов' unless more_than?(record, :soup, 2)
    errors << 'Менее двух салатов' unless more_than?(record, :salad, 2)
    has_defaults = (exists_default?(record, :soup) && exists_default?(record, :salad)) ||
                   (exists_default?(record, :main_dish) && exists_default?(record, :side_dish)) ||
                    exists_default?(record, :separate_dish)

    errors << 'Не указаны блюда по умолчанию' unless has_defaults
    errors << 'Количество гарниров не совпадает с количеством основных блюд' unless quantity_matches?(record, :main_dish, :side_dish)
  end

  def more_than?(record, dish_type, required_number)
    record.dishes.where(dish_type: dish_type).size > required_number
  end

  def exists_default?(record, dish_type)
    record.dishes.where(dish_type: dish_type).any? { |dish| dish.menu_dishes.exists?(default: true) }
  end

  def quantity_matches?(record, dish_one, dish_two)
    record.dishes.where(dish_type: dish_one).size == record.dishes.where(dish_type: dish_two).size
  end
end
