module Accounting
  class ExpensesController < ApplicationController
    layout 'accounting'
    def index
    end
    def new
      @entry = Accounting::Entry.new
      authorize @entry
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end

    def create
      @entry = Accounting::Entry.new(entry_params)
      authorize @entry
      if @entry.save
        redirect_to accounting_entries_path, notice: "Entry saved successfully."
      else
        render :new
      end
    end

    def show
      @entry = Accounting::Entry.find(params[:id])
      authorize @entry
    end

    def edit
      @entry = Accounting::Entry.find(params[:id])
    end

    def update
      @entry = Accounting::Entry.find(params[:id])
      authorize @entry
      @entry.update(entry_params)
      if @entry.save
        redirect_to accounting_entry_path(@entry), notice: "Entry updated successfully."
      else
        render :edit
      end
    end
    private
    def entry_params
      params.require(:accounting_entry).permit(:description, :entry_type,  :date, :reference_number, :entriable_id, :entriable_type, :credit_amounts_attributes=> [:id, :amount, :account],:debit_amounts_attributes=> [:id, :amount, :account])
    end
  end
end
