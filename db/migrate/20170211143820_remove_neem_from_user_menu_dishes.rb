class RemoveNeemFromUserMenuDishes < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_menu_dishes, :neem
  end
end
