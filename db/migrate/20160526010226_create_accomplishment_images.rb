class CreateAccomplishmentImages < ActiveRecord::Migration
  def change
    create_table :accomplishment_images do |t|
      t.belongs_to :work_accomplishment, index: true, foreign_key: true
      t.string :caption

      t.timestamps null: false
    end
  end
end
