class MenusDecorator < Draper::CollectionDecorator
  def col_index
    bootstrap_max_col_index = 12
    number_of_columns = object.empty? ? 1 : object.length
    bootstrap_max_col_index / number_of_columns
  end
end