class CreateLands < ActiveRecord::Migration
  def change
    create_table :lands do |t|
      t.decimal :cost
      t.integer :area

      t.timestamps null: false
    end
  end
end
