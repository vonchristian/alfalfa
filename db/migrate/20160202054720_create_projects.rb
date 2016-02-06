class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :main_contractor_id, index: true
      t.string  :id_number
      t.string  :name
      t.string  :address
      t.integer :status
      t.datetime :start_date
      t.datetime :target_completion_date
      t.decimal :cost
      t.timestamps null: false
    end
  end
end
