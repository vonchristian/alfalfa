class AddAmountToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :amount, :decimal
  end
end
