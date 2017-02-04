class CreateDishesMenusUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes_menus_users do |t|
      t.references :menus_user, foreign_key: true
      t.references :dish, foreign_key: true
      t.boolean :neem
    end
  end
end
