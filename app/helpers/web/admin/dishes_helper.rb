module Web::Admin::DishesHelper
  def current_dishes_path(dish)
    admin_dishes_path(q: { dish_type_eq: dish.respond_to?(:dish_type) ? dish.dish_type : dish })
  end

  def new_dish_of_type_path(dish_type)
    new_admin_dish_path(q: { dish_type_eq: dish_type })
  end
end
