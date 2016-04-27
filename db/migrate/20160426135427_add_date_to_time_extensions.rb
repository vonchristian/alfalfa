class AddDateToTimeExtensions < ActiveRecord::Migration
  def change
    add_column :time_extensions, :date, :datetime
  end
end
