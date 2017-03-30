class UserMenuDish < ActiveRecord::Base; end

class AddUniqueIndexToUserMenuDishes < ActiveRecord::Migration[5.0]
  def change
    grouped = UserMenuDish.all.group_by{ |model| [model.user_menu_id, model.dish_id] }
    grouped.values.each do |duplicates|
      duplicates.shift
      duplicates.each{ |duplicate| duplicate.destroy }
    end

    add_index :user_menu_dishes, [:user_menu_id, :dish_id], unique: true
  end
end
