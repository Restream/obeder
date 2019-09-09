class AddMenuDishCounters < ActiveRecord::Migration[5.0]
  def change
    add_column :menu_dishes, :vote_downs_count, :integer, default: 0
    add_column :menu_dishes, :vote_ups_count, :integer, default: 0
  end
end
