class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :inventory, index: true, foreign_key: true
      t.belongs_to :cart, index: true, foreign_key: true
      t.decimal :quantity, default: 1

      t.timestamps null: false
    end
  end
end
