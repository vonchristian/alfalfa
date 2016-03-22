class AddPaymentStatusToWorkAccomplishments < ActiveRecord::Migration
  def change
    add_column :work_accomplishments, :payment_status, :integer
  end
end
