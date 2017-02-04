class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.boolean :neem
      t.string :description
    end
  end
end
