class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :code
      t.string :description
      t.string :unit
      t.decimal :quantity
      t.decimal :unit_cost
      t.decimal :total_cost
      t.belongs_to :work_detail, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
