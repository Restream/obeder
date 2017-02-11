class AddNeemDefaultToUserMenuDishes < ActiveRecord::Migration[5.0]
  def change
    change_column_default :user_menu_dishes, :neem, false
  end
end
