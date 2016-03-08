class AddDescriptionToCashAdvances < ActiveRecord::Migration
  def change
    add_column :cash_advances, :description, :string
  end
end
