class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address
      t.string :mobile_number
      t.string :sex
      t.date :birth_date
      t.string :email
      t.integer :position
      t.string :photo_id

      t.timestamps null: false
    end
  end
end
