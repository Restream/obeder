class MenuDishDecorator < Draper::Decorator
  delegate_all

  def dish_name(default_mark)
    dish_name = model.dish.name
    model.default ? [dish_name, default_mark].join(', ') : dish_name
  end
end