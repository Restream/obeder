class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.date :date
      t.boolean :ready
    end
  end
end
