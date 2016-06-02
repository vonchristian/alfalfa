class AddHaulingCostToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :hauling_cost, :decimal
  end
end
