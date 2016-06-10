class RemoveColumnAmountFromBidExpenses < ActiveRecord::Migration
  def change
  	remove_column :bid_expenses, :amount, :decimal
  end
end
