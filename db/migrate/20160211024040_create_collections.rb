class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.datetime :date
      t.belongs_to :project, index: true, foreign_key: true
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
