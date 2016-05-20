class AddQuantityToAmountRevisions < ActiveRecord::Migration
  def change
    add_column :amount_revisions, :quantity, :decimal
  end
end
