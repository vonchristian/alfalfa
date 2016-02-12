class ExpensesController < ApplicationController
  def index
    @expenses = Plutus::Entry.all.order('created_at DESC')
  end
  def new
    @expense = Plutus::Entry.new
    @expense.credit_amounts.build
    @expense.debit_amounts.build
  end

  def create
    @expense = Plutus::Entry.new(expenses_params)
    if @expense.save
      redirect_to expenses_path, notice: "Expense Recorded successfully"
    else
      render :new
    end
  end
  
  def show
    @expense = Plutus::Entry.find(params[:id])
  end
  private
  def expense_params
    params.require(:entry).permit(:description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
