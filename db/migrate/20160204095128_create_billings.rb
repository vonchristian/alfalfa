class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :contractor, index: true, foreign_key: true
      t.belongs_to :inventory, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
