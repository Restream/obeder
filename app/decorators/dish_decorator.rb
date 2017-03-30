class DishDecorator < Draper::Decorator
  delegate_all

  def name_and_type
    [model.name, model.dish_type.text].join(' | ')
  end
end
