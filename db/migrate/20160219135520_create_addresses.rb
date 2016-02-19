class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :sitio
      t.string :barangay
      t.string :municipality
      t.string :province
      t.integer :addressable_id, index: true
      t.string :addressable_type
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
