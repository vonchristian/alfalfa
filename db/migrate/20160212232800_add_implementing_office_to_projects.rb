class AddImplementingOfficeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :implementing_office, :string
  end
end
