class CreateItemBudgets < ActiveRecord::Migration
  def change
    create_table :item_budgets do |t|
      t.string :unit
      t.string :quantity
      t.decimal :unit_price
      t.decimal :amount
      t.belongs_to :project, index: true, foreign_key: true
      t.string :item_code
      t.string :item_description
      t.timestamps null: false
    end
  end
end
