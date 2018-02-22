class UserMenuSerializer < ActiveModel::Serializer
  attributes :id, :date, :user_name, :description, :dishes, :neem, :editable

  def user_name
    object.user.name
  end

  def date
    object.menu.date
  end

  def dishes
    menu_dishes = object.menu.menu_dishes.includes(:dish, :votes)
    user_dish_ids = object.dishes.pluck(:id)

    menu_dishes.map do |menu_dish|
      dish = menu_dish.dish

      placed_users_votes = menu_dish.votes.index_by(&:user_id)
      current_user_vote = placed_users_votes[current_user.id].presence

      dish_hash = DishSerializer.new(dish).attributes
      dish_hash[:selected] = user_dish_ids.include?(dish.id)
      dish_hash[:default] = menu_dish.default
      dish_hash[:rating_up] = menu_dish.dish.vote_ups_count
      dish_hash[:rating_down] = menu_dish.dish.vote_downs_count
      dish_hash[:voted] = current_user_vote&.vote
      dish_hash
    end
  end
end
