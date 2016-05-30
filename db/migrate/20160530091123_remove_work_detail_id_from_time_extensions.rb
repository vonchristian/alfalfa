class RemoveWorkDetailIdFromTimeExtensions < ActiveRecord::Migration
  def up
    remove_column :time_extensions, :work_detail_id, :integer
  end
  def down
    add_column :time_extensions, :work_detail_id, :integer, index: true
  end
end
