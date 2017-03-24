class DishesDecorator < Draper::CollectionDecorator
  def names
    object.map(&:name).join(', ')
  end
end
