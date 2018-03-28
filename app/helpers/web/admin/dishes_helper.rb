module Web::Admin::DishesHelper
  def current_dishes_path(dish_type)
    admin_dishes_path(q: { dish_type_eq: dish_type })
  end

  def new_dish_path(dish_type)
    new_admin_dish_path(q: { dish_type_eq: dish_type })
  end
end
