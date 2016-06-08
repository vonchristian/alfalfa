class RemoveTotalCostAndUnitCostFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :total_cost, :string
    remove_column :items, :unit_cost, :string
  end
end
