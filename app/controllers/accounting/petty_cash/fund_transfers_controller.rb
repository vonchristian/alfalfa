module Accounting
  class PettyCash::FundTransfersController < ApplicationController
    layout "accounting"
    def new
      @petty_cash = Asset.find_by_name!("Petty Cash")
      @entry = Accounting::Entry.new
      # authorize @entry
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end

    def create
      @petty_cash = Asset.find_by_name!("Petty Cash")
      @entry = Accounting::Entry.new(entry_params)
      # authorize @entry
      if @entry.save
        redirect_to accounting_petty_cash_index_path, notice: "Fund Transfer saved successfully."
      else
        render :new
      end
    end

    def show
      @entry = Entry.find(params[:id])
    end

    private
    def entry_params
      params.require(:accounting_entry).permit(:date, :entriable_id, :entriable_type, :reference_number, :description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
