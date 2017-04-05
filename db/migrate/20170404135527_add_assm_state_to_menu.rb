class Menu < ActiveRecord::Base; end

class AddAssmStateToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :aasm_state, :string

    ready_menus = Menu.where(ready: true)
    ready_menus.find_each do |menu|
      menu.approve
      menu.publish!
    end
  end
end
