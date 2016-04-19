class AddTotalCostToRestockings < ActiveRecord::Migration
  def change
  	add_column :restockings, :total_cost, :decimal
  end
end
