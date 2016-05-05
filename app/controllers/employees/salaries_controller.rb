class Employees::SalariesController < ApplicationController
  layout "accounting"
  def new
    @employee = Employee.find(params[:employee_id])
    @entry = Transactions::SalaryPayment.new
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @entry = Transactions::SalaryPayment.create(entry_params)
    @entry.entriable = @employee
    if @entry.save
      @entry.entriable.paid!
      redirect_to payroll_index_path, notice: "Employee Salary paid successfully."
    else
      render :new
    end
  end

  private
  def entry_params
    params.require(:transactions_salary_payment).permit(:description, :date, :reference_number, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
