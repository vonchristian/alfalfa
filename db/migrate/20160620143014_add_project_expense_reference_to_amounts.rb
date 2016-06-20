class AddProjectExpenseReferenceToAmounts < ActiveRecord::Migration
  def change
  	add_reference :amounts, :project_expense, index: true
  end
end
