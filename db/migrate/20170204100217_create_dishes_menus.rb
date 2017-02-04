class CreateDishesMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes_menus do |t|
      t.references :menu, foreign_key: true
      t.references :dish, foreign_key: true
      t.boolean :default
    end
  end
end
