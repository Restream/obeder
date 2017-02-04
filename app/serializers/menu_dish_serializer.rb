class MenuDishSerializer < ActiveModel::Serializer
  attributes :id, :dish_id, :default, :name, :description

  def name
    object.dish.name
  end

  def description
    object.dish.description
  end
end
