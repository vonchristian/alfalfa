class AddEquipmentExpenseReferenceToAmounts < ActiveRecord::Migration
  def change
  	add_reference :amounts, :equipment_expense, index: true
  end
end
