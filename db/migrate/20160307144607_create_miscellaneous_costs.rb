class CreateMiscellaneousCosts < ActiveRecord::Migration
  def change
    create_table :miscellaneous_costs do |t|
      t.string :description
      t.decimal :amount
      t.belongs_to :work_detail, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
