class MenuPublishReadinessValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:dishes] << 'Менее двух супов' unless record.dishes.where(dish_type: :soup).size < 2
    record.errors[:dishes] << 'Менее двух салатов' unless record.dishes.where(dish_type: :salad).size < 2
  end
end
