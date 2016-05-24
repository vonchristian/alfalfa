class CreateOvertimes < ActiveRecord::Migration
  def change
    create_table :overtimes do |t|
      t.belongs_to :employee, index: true, foreign_key: true
      t.decimal :number_of_hours
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
