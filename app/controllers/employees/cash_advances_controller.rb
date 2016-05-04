class Employees::CashAdvancesController < ApplicationController
  layout "accounting"
  def new
  @employee = Employee.find(params[:employee_id])
    @entry = Entry.new
    authorize @entry
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @entry = Entry.create(entry_params)
    authorize @entry
    @entry.entriable = @employee
    if @entry.save
      redirect_to @employee, notice: "Cash Advance recorded successfully."
    else
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  private
  def entry_params
    params.require(:entry).permit(:date, :description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
