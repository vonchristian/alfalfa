class AddProjectIdToWorkers < ActiveRecord::Migration
  def change
    add_column :workers, :project_id, :integer
    add_index :workers, :project_id
  end
end
