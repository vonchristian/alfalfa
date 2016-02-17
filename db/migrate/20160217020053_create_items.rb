class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :division, index: true, foreign_key: true
      t.string :code
      t.string :description

      t.timestamps null: false
    end
  end
end
