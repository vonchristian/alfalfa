class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :description
      t.string :received_by
      t.string :disbursed_by
      t.datetime :date
      t.integer :expensable_id, index: true
      t.string :expensable_type, index: true
      t.timestamps null: false
    end
  end
end
