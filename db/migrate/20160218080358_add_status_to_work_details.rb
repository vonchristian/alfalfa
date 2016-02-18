class AddStatusToWorkDetails < ActiveRecord::Migration
  def change
    add_column :work_details, :status, :integer
  end
end
