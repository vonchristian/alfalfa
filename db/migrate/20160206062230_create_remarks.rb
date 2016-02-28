class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.integer :remarker_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
