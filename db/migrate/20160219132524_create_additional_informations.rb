class CreateAdditionalInformations < ActiveRecord::Migration
  def change
    create_table :additional_informations do |t|
      t.string :sex
      t.datetime :birth_date
      t.string :birth_place
      t.string :civil_status
      t.string :nationality
      t.integer :informeable_id, index: true
      t.string :informeable_type
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
