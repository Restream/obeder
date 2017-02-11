class AddNeemToUserMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :user_menus, :neem, :boolean, default: false
  end
end
