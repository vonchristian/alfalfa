class AddEmployeeExpenseReferencesToAmounts < ActiveRecord::Migration
  def change
  	add_reference :amounts, :employee_expense, index: true
  end
end
