module Accounting
  class ProjectExpensesController < ApplicationController
    layout "accounting"

    def index
      if params[:query].present?
        @project_expenses = ProjectExpense.search_by_query(params[:query]).order(:created_at).page(params[:page]).per(30)
        authorize @project_expenses, :index?
      else
        @project_expenses = ProjectExpense.all.order('date DESC').page(params[:page]).per(30)
        authorize @project_expenses, :index?
        @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
        @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
        respond_to do |format|
          format.html
          format.pdf do
            pdf = EmployeeExpensePdf.new(@project_expenses, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Employee Expense Report.pdf"
          end
        end
      end
    end

    def scope_to_date
      @project_expenses = ProjectExpense.created_between(params[:from_date], params[:to_date]).page(params[:page]).per(50)
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PettyCashPdf.new(@project_expenses, @from_date, @to_date, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Employee Expense Report.pdf"
        end
      end
    end

    def new
      @project_expense = ProjectExpense.new
      # authorize @project_expense
      @project_expense.credit_amounts.build
      @project_expense.debit_amounts.build
    end

    def create
      @project_expense = ProjectExpense.new(project_expense_params)
      authorize @project_expense
      if @project_expense.save
        redirect_to accounting_project_expenses_path, notice: "Project Expense saved successfully."
      else
        render :new
      end
    end

    def show
      @project_expense = ProjectExpense.find(params[:id])
      authorize @project_expense
    end

    def edit
      @project_expense = ProjectExpense.find(params[:id])
    end

    def update
      @project_expense = ProjectExpense.find(params[:id])
      authorize @project_expense
      @project_expense.update(project_expense_params)
      if @project_expense.save
        redirect_to accounting_project_expense_path(@project_expense), notice: "Project Expense updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @project_expense = ProjectExpense.find(params[:id])
      if @project_expense.destroy
        redirect_to accounting_project_expenses_path, notice: 'Project Expense deleted successful.'
      end
    end

    private
    def project_expense_params
      params.require(:project_expense).permit(:description, :entry_type, :date, :reference_number, :entriable_id, :entriable_type, :credit_amounts_attributes=> [:id, :amount, :account],:debit_amounts_attributes=> [:id, :amount, :account])
    end
  end
end
