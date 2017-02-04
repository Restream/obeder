class CreateMenusUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :menus_users do |t|
      t.uuid :user_id
      t.references :menu, foreign_key: true
    end
    add_foreign_key :menus_users, :users
  end
end
