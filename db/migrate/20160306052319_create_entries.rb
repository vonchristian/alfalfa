class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.datetime :date
      t.integer :entriable_id
      t.string :entriable_type
       t.string :description
      t.timestamps null: false
    end
    add_index :entries, :entriable_id
    add_index :entries, :entriable_type
  end
end
