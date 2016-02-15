class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.belongs_to :employee, index: true, foreign_key: true
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
