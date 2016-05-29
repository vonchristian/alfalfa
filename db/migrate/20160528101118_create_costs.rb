class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :type
      t.string :description
      t.decimal :quantity
      t.string :unit
      t.decimal :unit_cost
      t.decimal :total_cost
      t.datetime :date

      t.timestamps null: false
    end
  end
end
