module Expenses
  class EntriesController < ApplicationController
    def index
      @entries = Plutus::Entry.all
    end
    def new
      @expense = Plutus::Expense.find(params[:expense_id])
      @entry = Plutus::Entry.new
      @expense.credit_amounts.build
      @expense.debit_amounts.build
    end

    def create
      @expense = Plutus::Expense.find(params[:expense_id])
      @entry = Plutus::Entry.new(entry_params)
      if @entry.save
        redirect_to entries_path, notice: "Success"
      else
        render :new
      end
    end

    private
    def entry_params
      params.require(:entry).permit(:description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
