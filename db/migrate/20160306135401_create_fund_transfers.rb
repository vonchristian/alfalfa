class CreateFundTransfers < ActiveRecord::Migration
  def change
    create_table :fund_transfers do |t|
      t.integer :source_account_id
      t.integer :recipient_account_id
      t.integer :fund_transfer_type
      t.decimal :amount
      t.datetime :date

      t.timestamps null: false
    end
    add_index :fund_transfers, :source_account_id
    add_index :fund_transfers, :recipient_account_id
  end
end
