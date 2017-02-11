class UserMenuSerializer < ActiveModel::Serializer
  attributes :id, :date, :user_name, :description, :dishes

  def user_name
    object.user.name
  end

  def date
    object.menu.date
  end

  def dishes
    menu_dishes = object.menu.menu_dishes
    user_dish_ids = object.dishes.pluck(:id)

    menu_dishes.map do |menu_dish|
      dish = menu_dish.dish
      dish_hash = DishSerializer.new(dish).attributes
      dish_hash[:selected] = user_dish_ids.include?(dish.id)
      dish_hash[:default] = menu_dish.default

      dish_hash
    end
  end
end
