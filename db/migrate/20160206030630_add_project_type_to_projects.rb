class AddProjectTypeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :classification, :integer
  end
end
