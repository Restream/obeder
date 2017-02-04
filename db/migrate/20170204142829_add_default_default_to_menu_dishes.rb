class AddDefaultDefaultToMenuDishes < ActiveRecord::Migration[5.0]
  def change
    change_column_default :menu_dishes, :default, false
  end
end
