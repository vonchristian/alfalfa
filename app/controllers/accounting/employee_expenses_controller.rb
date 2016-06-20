module Accounting
  class EmployeeExpensesController < ApplicationController
    layout "accounting"

    def index
      if params[:query].present?
        @employee_expenses = EmployeeExpense.search_by_query(params[:query]).order(:created_at).page(params[:page]).per(30)
        authorize @employee_expenses, :index?
      else
        @employee_expenses = EmployeeExpense.all.order('date DESC').page(params[:page]).per(30)
        authorize @employee_expenses, :index?
        @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
        @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
        respond_to do |format|
          format.html
          format.pdf do
            pdf = EmployeeExpensePdf.new(@employee_expenses, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Employee Expense Report.pdf"
          end
        end
      end
    end

    def scope_to_date
      @employee_expenses = EmployeeExpense.created_between(params[:from_date], params[:to_date]).page(params[:page]).per(50)
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PettyCashPdf.new(@employee_expenses, @from_date, @to_date, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Employee Expense Report.pdf"
        end
      end
    end

    def new
      @employee_expense = EmployeeExpense.new
      # authorize @employee_expense
      @employee_expense.credit_amounts.build
      @employee_expense.debit_amounts.build
    end

    def create
      @employee_expense = EmployeeExpense.new(employee_expense_params)
      authorize @employee_expense
      if @employee_expense.save
        redirect_to accounting_employee_expenses_path, notice: "Employee Expense saved successfully."
      else
        render :new
      end
    end

    def show
      @employee_expense = EmployeeExpense.find(params[:id])
      authorize @employee_expense
    end

    def edit
      @employee_expense = EmployeeExpense.find(params[:id])
    end

    def update
      @employee_expense = EmployeeExpense.find(params[:id])
      authorize @employee_expense
      @employee_expense.update(employee_expense_params)
      if @employee_expense.save
        redirect_to accounting_employee_expense_path(@employee_expense), notice: "Employee Expense updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @employee_expense = EmployeeExpense.find(params[:id])
      if @employee_expense.destroy
        redirect_to accounting_employee_expenses_path, notice: 'Employee Expense deleted successful.'
      end
    end

    private
    def employee_expense_params
      params.require(:employee_expense).permit(:description, :entry_type, :date, :reference_number, :entriable_id, :entriable_type, :credit_amounts_attributes=> [:id, :amount, :account],:debit_amounts_attributes=> [:id, :amount, :account])
    end
  end
end
