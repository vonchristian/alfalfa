class CreateWorkedDays < ActiveRecord::Migration
  def change
    create_table :worked_days do |t|
      t.decimal :number_of_days
      t.belongs_to :employee, index: true, foreign_key: true
      t.belongs_to :project, index: true, :foreign_key => true
      t.integer :status
      t.timestamps null: false
    end
  end
end
