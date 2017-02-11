class AddDescriptionToUserMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :user_menus, :description, :text
  end
end
