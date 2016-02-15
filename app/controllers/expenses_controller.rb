class ExpensesController < ApplicationController
  def index
    @expenses = Plutus::Expense.all.order('created_at DESC')
  end
  def new
    @expense = Plutus::Expense.new
  end

 
  def show
    @expense = Plutus::Expense.find(params[:id])
  end
  def filtered_data
      @from_date = params[:from_date] ? Date.parse(params[:from_date]) : Date.today.at_beginning_of_month
      @to_date = params[:to_date] ? Date.parse(params[:to_date]) : Date.today
      @expenses = Plutus::Expense.all
      @entries = @expenses.all.each.map{|expense| expense.debit_entries }

      respond_to do |format|
        format.html # index.html.erb
      end
    end
  private
  def expense_params
    params.require(:entry).permit(:description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
