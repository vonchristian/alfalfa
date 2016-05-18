class Equipment::FuelExpensesController < ApplicationController
  layout 'supplies'
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @fuel_expense = @equipment.fuel_expenses.build
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @fuel_expense = @equipment.fuel_expenses.create(fuel_expense_params)
    if @fuel_expense.save
      redirect_to @equipment, notice: "Fuel Expense saved successfully."
    else
      render :new
    end
  end

  private
  def fuel_expense_params
    params.require(:issued_inventory).permit( :inventory_id, :quantity, :total_cost, :date_issued)
  end


end
