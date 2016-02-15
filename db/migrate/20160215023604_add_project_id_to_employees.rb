class AddProjectIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :project_id, :integer
    add_index :employees, :project_id
  end
end
