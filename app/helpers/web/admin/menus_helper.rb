module Web::Admin::MenusHelper
  def col_index(menus)
    bootstrap_max_col_index = 12
    number_of_columns = menus.empty? ? 1 : menus.size
    bootstrap_max_col_index / number_of_columns
  end
end
