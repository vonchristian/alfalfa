class AddItemCategoryIdToInventory < ActiveRecord::Migration
  def change
  	add_column :inventories, :item_category_id, :integer
  	add_index :inventories, :item_category_id
  end
end
