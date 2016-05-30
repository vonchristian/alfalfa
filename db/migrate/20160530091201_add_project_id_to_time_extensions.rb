class AddProjectIdToTimeExtensions < ActiveRecord::Migration
  def change
    add_column :time_extensions, :project_id, :integer
    add_index :time_extensions, :project_id
  end
end
