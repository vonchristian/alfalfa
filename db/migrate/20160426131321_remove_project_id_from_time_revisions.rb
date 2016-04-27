class RemoveProjectIdFromTimeRevisions < ActiveRecord::Migration
  def up
    remove_index :time_extensions, :project_id
    remove_column :time_extensions, :project_id, :integer
  end
  def down
    add_column :time_extensions, :project_id, :integer
    add_index :time_extensions, :project_id
  end
end
