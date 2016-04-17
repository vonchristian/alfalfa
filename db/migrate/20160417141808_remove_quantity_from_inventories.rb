class RemoveQuantityFromInventories < ActiveRecord::Migration
  def change
    remove_column :inventories, :quantity, :decimal
     remove_column :inventories, :cost, :decimal
  end
end
