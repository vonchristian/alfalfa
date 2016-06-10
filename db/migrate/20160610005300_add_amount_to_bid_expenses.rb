class AddAmountToBidExpenses < ActiveRecord::Migration
  def change
  	add_column :bid_expenses, :amount, :decimal, default: 0
  end
end
