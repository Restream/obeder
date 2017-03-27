class UsersDecorator < Draper::CollectionDecorator
  def names
    object.map(&:name).join(', ')
  end
end
