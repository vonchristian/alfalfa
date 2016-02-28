class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :contractor, index: true, foreign_key: true
      t.decimal :amount_subcontracted

      t.timestamps null: false
    end
  end
end
