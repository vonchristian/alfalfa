class AddProjectIdToIssuedInventories < ActiveRecord::Migration
  def change
  	add_column :issued_inventories, :project_id, :integer, index: true, foreign_key: true
  	add_column :issued_inventories, :work_detail_id, :integer, index: true, foreign_key: true
  end
end
