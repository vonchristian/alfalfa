class AddRecipientToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :recipient, :string
  end
end
