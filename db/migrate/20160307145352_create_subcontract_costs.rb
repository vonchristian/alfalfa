class CreateSubcontractCosts < ActiveRecord::Migration
  def change
    create_table :subcontract_costs do |t|
      t.decimal :amount
      t.belongs_to :contractor, index: true, foreign_key: true
      t.string :quantity
      t.belongs_to :work_detail, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
