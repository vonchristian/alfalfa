class AddWorkDetailIdToTimeExtensions < ActiveRecord::Migration
  def change
    add_reference :time_extensions, :work_detail, index: true, foreign_key: true
  end
end
