class RenameTables < ActiveRecord::Migration[5.0]
  def change
    rename_table :menus_users, :user_menus
    rename_table :dishes_menus_users, :user_menu_dishes
    rename_table :dishes_menus, :menu_dishes

    rename_column :user_menu_dishes, :menus_user_id, :user_menu_id
  end
end
