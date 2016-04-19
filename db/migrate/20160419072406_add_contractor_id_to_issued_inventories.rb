class AddContractorIdToIssuedInventories < ActiveRecord::Migration
  def change
  	add_column :issued_inventories, :contractor_id, :integer, index: true, foreign_key: true
  end
end
