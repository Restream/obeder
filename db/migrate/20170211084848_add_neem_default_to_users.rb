class AddNeemDefaultToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :neem, false
  end
end
