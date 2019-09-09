class UserMenuVoteTypeSerializer < ActiveModel::Serializer
  attributes :user_menu_id, :dish_id, :rating_up, :rating_down

  delegate :user_menu_id, :dish_id, to: :object

  def rating_up
    object.voteable.dish.vote_ups_count
  end

  def rating_down
    object.voteable.dish.vote_downs_count
  end
end
