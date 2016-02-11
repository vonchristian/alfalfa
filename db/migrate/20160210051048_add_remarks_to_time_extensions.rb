class AddRemarksToTimeExtensions < ActiveRecord::Migration
  def change
    add_column :time_extensions, :remark, :text
  end
end
