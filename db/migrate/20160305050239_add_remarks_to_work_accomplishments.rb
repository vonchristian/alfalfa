class AddRemarksToWorkAccomplishments < ActiveRecord::Migration
  def change
    add_column :work_accomplishments, :remarks, :text
  end
end
