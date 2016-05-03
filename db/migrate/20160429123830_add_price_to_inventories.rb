class AddPriceToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :price, :decimal, precision: 2, scale: 9
  end
end
