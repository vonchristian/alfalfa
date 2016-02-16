class CreateDepreciations < ActiveRecord::Migration
  def change
    create_table :depreciations do |t|
      t.decimal :amount
      t.integer :depreciationable_id, index: true
      t.string :depreciationable_type, index: true

      t.timestamps null: false
    end
  end
end
