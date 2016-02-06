class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.belongs_to :bid, index: true, foreign_key: true
      t.belongs_to :document, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
