class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances do |t|
      t.belongs_to :equipment, index: true, foreign_key: true
      t.date :date
      t.string :description
      t.decimal :quantity
      t.string :unit
      t.decimal :amount
      t.string :remarks
      t.belongs_to :employee, index: true, foreign_key: true
      t.belongs_to :work_detail, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
