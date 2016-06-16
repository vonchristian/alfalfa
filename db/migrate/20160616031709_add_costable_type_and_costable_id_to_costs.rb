class AddCostableTypeAndCostableIdToCosts < ActiveRecord::Migration
  def change
    add_column :costs, :costable_type, :string, index: true
    add_column :costs, :costable_id, :integer, index: true
  end
end
