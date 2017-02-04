class MenuSerializer < ActiveModel::Serializer
  attributes :id, :date, :dishes

  def dishes
    object.menu_dishes.map do |menu_dish|
      dish = menu_dish.dish
      dish_hash = DishSerializer.new(dish).attributes
      dish_hash[:default] = menu_dish.default

      dish_hash
    end
  end
end
