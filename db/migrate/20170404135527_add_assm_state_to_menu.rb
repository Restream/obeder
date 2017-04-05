class AddAssmStateToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :aasm_state, :string
  end
end
