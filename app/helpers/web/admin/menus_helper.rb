module Web::Admin::MenusHelper
  def col_index(menus)
    bootstrap_max_col_index = 12
    number_of_columns = menus.empty? ? 1 : menus.size
    bootstrap_max_col_index / number_of_columns
  end

  def dish_name(menu_dish)
    text = "#{ menu_dish.dish.name } (#{ menu_dish.dish.dish_type.text })"
    menu_dish.default? ? content_tag(:strong, text) : content_tag(:div, text)
  end
end
