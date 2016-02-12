class CreateProjectBillings < ActiveRecord::Migration
  def change
    create_table :project_billings do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :billing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
