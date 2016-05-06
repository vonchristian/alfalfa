class AddProjectIdToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :project_id, :integer, index: true, foreign_key: true
  end
end
