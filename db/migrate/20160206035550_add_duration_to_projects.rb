class AddDurationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :duration, :integer
    remove_column :projects, :start_date
    remove_column :projects, :target_completion_date
  end
end
