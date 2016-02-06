class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
