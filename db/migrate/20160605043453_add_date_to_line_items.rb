class AddDateToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :date, :datetime
  end
end
