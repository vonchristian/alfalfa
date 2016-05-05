module Employees
  class CashAdvancesController < ApplicationController
    layout "accounting"
    def new
    @employee = Employee.find(params[:employee_id])
      @cash_advance = Transactions::CashAdvance.new
      # authorize @cash_advance
      @cash_advance.credit_amounts.build
      @cash_advance.debit_amounts.build
    end

    def create
      @employee = Employee.find(params[:employee_id])
      @cash_advance = Transactions::CashAdvance.create(cash_advance_params)
      # authorize @cash_advance
      @cash_advance.entriable = @employee
      if @cash_advance.save
        redirect_to @employee, notice: "Cash Advance recorded successfully."
      else
        render :new
      end
    end

    def show
      @cash_advance = cash_advance.find(params[:id])
    end

    private
    def cash_advance_params
      params.require(:transactions_cash_advance).permit(:date, :reference_number, :description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
