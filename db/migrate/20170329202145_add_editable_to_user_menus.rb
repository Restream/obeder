class AddEditableToUserMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :user_menus, :editable, :boolean, default: true
  end
end
