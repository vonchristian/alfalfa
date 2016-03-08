class AddStatusToCashAdvances < ActiveRecord::Migration
  def change
    add_column :cash_advances, :status, :integer
  end
end
