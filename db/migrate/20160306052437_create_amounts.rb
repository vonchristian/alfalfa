class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.string :type
      t.references :account
      t.references :entry
      t.decimal :amount, :precision => 20, :scale => 10
    end
    add_index :amounts, :type
    add_index :amounts, [:account_id, :entry_id]
    add_index :amounts, [:entry_id, :account_id]
  end
end
