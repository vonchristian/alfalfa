class CreateBillableMaterials < ActiveRecord::Migration
  def change
    create_table :billable_materials do |t|
      t.belongs_to :contractor, index: true, foreign_key: true
      t.belongs_to :inventory, index: true, foreign_key: true
      t.decimal :cost
      t.integer :reference_number
      t.integer :quantity
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
