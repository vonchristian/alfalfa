class AddDateIssuedToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :date_issued, :datetime
  end
end
