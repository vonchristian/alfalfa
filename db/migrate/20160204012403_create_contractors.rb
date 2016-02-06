class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.boolean :main_contractor
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :company
      t.string :position

      t.timestamps null: false
    end
  end
end
