class AddPaymentStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_status, :integer, default: 1
  end
end
