class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :code, index: true
      t.string :name, index: true
      t.string :type, index: true
      t.boolean :contra

      t.timestamps null: false
    end
  end
end
