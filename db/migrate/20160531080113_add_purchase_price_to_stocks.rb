class AddPurchasePriceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :unit_cost, :decimal
    add_column :stocks, :total_cost, :decimal
  end
end
