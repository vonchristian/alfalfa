class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :main_contractor_id, index: true
      t.string  :id_number
      t.string  :name
      t.string  :address
      t.integer :status
     t.integer :duration
      t.decimal :cost
      t.integer :classification
      t.timestamps null: false
    end
  end
end
