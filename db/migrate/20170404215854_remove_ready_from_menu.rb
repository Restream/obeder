class RemoveReadyFromMenu < ActiveRecord::Migration[5.0]
  def change
    remove_column :menus, :ready, :boolean, default: false
  end
end
