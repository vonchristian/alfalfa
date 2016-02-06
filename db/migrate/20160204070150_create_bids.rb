class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.references :bidders
      t.references :documents
      t.timestamps null: false
    end
  end
end
