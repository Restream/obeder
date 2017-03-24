class DishesDecorator < Draper::CollectionDecorator
  def names
    object.map(&:name).join(', ')
  end

  def names_or_default(default_dishes, default_marker)
    default_dishes == object ? default_marker : names
  end
end
