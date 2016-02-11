class CreateAccomplishments < ActiveRecord::Migration
  def change
    create_table :accomplishments do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.float :percent
      t.string :remarks

      t.timestamps null: false
    end
  end
end
