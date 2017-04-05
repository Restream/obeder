class Menu < ActiveRecord::Base; end

class AddAssmStateToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :aasm_state, :string

    Menu.where(ready: true).update_all(aasm_state: :published)
  end
end
