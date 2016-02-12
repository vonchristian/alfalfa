class AddProjectBillingIdToBillings < ActiveRecord::Migration
  def change
    add_reference :billings, :project_billing, index: true, foreign_key: true
  end
end
