class AddTitleToRemarks < ActiveRecord::Migration
  def change
    add_column :remarks, :title, :string
    add_column :remarks, :remarker_id, :integer
  end
end
