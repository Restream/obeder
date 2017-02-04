class AddReadyDefaultToMenus < ActiveRecord::Migration[5.0]
  def change
    change_column_default :menus, :ready, false
  end
end
