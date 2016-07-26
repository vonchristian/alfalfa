class AddPurposeToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :purpose, :string
  end
end
