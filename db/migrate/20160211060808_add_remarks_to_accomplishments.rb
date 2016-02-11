class AddRemarksToAccomplishments < ActiveRecord::Migration
  def change
    add_column :accomplishments, :remarks, :text
  end
end
