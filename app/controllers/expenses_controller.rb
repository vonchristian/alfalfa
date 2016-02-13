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
  private
  def expense_params
    params.require(:entry).permit(:description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
