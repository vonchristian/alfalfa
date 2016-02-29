class CreateCashAdvances < ActiveRecord::Migration
  def change
    create_table :cash_advances do |t|
      t.integer :cash_advanceable_id
      t.string :cash_advanceable_type
      t.decimal :amount
      t.datetime :date_disbursed

      t.timestamps null: false
    end
    add_index :cash_advances, :cash_advanceable_id
    add_index :cash_advances, :cash_advanceable_type
  end
end
