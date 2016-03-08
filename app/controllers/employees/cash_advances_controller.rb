class Employees::CashAdvancesController < ApplicationController
  def new
    @employee = Employee.find(params[:employee_id])
    @cash_advance = @employee.cash_advances.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @cash_advance = @employee.cash_advances.create(cash_advance_params)
    if @cash_advance.save
      @cash_advance.unpaid!
      redirect_to @employee, notice: "Cash Advance recorded successfully."
    else
      render :new
    end
  end

  private
  def cash_advance_params
    params.require(:cash_advance).permit(:amount, :date_disbursed, :description)
  end
end
