class AddDishCounters < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :vote_downs_count, :integer, default: 0
    add_column :dishes, :vote_ups_count, :integer, default: 0
  end
end
