class CreateTimeExtensions < ActiveRecord::Migration
  def change
    create_table :time_extensions do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.integer :number_of_days

      t.timestamps null: false
    end
  end
end
