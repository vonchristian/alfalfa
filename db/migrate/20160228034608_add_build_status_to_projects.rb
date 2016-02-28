class AddBuildStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :build_status, :string
  end
end
