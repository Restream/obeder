class RemoveReadyFromMenu < ActiveRecord::Migration[5.0]
  def change
    remove_column :menus, :ready
  end
end
