class UserMenuSerializer < ActiveModel::Serializer
  attributes :id, :date, :dishes

  def dishes
    user = instance_options[:user]
    user_menu = object.user_menus.find_by(user_id: user.id)
    return [] if user_menu.blank?

    user_dish_ids = user_menu.dishes.pluck(:id)

    object.dishes.map do |dish|
      dish_hash = DishSerializer.new(dish).attributes
      dish_hash[:selected] = user_dish_ids.include?(dish.id)

      dish_hash
    end
  end
end
