class AddProjectTypePhotoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_type_photo, :string
  end
end
