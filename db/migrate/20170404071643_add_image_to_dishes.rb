class AddImageToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :image, :string
  end
end
