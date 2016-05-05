module Accounting
  class PettyCash::FundTransfersController < ApplicationController
    layout "accounting"
    def new
      @petty_cash = Asset.find_by_name!("Petty Cash")
      @entry = Transactions::FundTransfer.new
      # authorize @entry
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end

    def create
      @petty_cash = Asset.find_by_name!("Petty Cash")
      @entry = Transactions::FundTransfer.new(entry_params)
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
      params.require(:transactions_fund_transfer).permit(:date, :entriable_id, :entriable_type, :reference_number, :description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
