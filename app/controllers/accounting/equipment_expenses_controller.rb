module Accounting
  class EquipmentExpensesController < ApplicationController
    layout "accounting"

    def index
      if params[:query].present?
        @equipment_expenses = EquipmentExpense.search_by_query(params[:query]).order(:created_at).page(params[:page]).per(30)
        authorize @equipment_expenses, :index?
      else
        @equipment_expenses = EquipmentExpense.all.order('date DESC').page(params[:page]).per(30)
        authorize @equipment_expenses, :index?
        @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
        @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
        respond_to do |format|
          format.html
          format.pdf do
            pdf = EquipmentExpensePdf.new(@equipment_expenses, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Employee Expense Report.pdf"
          end
        end
      end
    end

    def scope_to_date
      @equipment_expenses = EquipmentExpense.created_between(params[:from_date], params[:to_date]).page(params[:page]).per(50)
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PettyCashPdf.new(@equipment_expenses, @from_date, @to_date, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Employee Expense Report.pdf"
        end
      end
    end

    def new
      @equipment_expense = EquipmentExpense.new
      # authorize @equipment_expense
      @equipment_expense.credit_amounts.build
      @equipment_expense.debit_amounts.build
    end

    def create
      @equipment_expense = EquipmentExpense.new(equipment_expense_params)
      authorize @equipment_expense
      if @equipment_expense.save
        redirect_to accounting_equipment_expenses_path, notice: "Equipment Expense saved successfully."
      else
        render :new
      end
    end

    def show
      @equipment_expense = EquipmentExpense.find(params[:id])
      authorize @equipment_expense
    end

    def edit
      @equipment_expense = EquipmentExpense.find(params[:id])
    end

    def update
      @equipment_expense = EquipmentExpense.find(params[:id])
      authorize @equipment_expense
      @equipment_expense.update(equipment_expense_params)
      if @equipment_expense.save
        redirect_to accounting_equipment_expense_path(@equipment_expense), notice: "Equipment Expense updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @equipment_expense = EquipmentExpense.find(params[:id])
      if @equipment_expense.destroy
        redirect_to accounting_equipment_expenses_path, notice: 'Equipment Expense deleted successful.'
      end
    end

    private
    def equipment_expense_params
      params.require(:equipment_expense).permit(:description, :entry_type, :date, :reference_number, :entriable_id, :entriable_type, :credit_amounts_attributes=> [:id, :amount, :account],:debit_amounts_attributes=> [:id, :amount, :account])
    end
  end
end
