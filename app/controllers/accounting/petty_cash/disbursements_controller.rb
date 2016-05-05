module Accounting
  class PettyCash::DisbursementsController < ApplicationController
    layout "accounting"
    def new
      @petty_cash = Asset.find_by_name!("Petty Cash")
      @entry = Transactions::Disbursement.new
      # authorize @entry
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end

    def create
      @petty_cash = Asset.find_by_name!("Petty Cash")
      @entry = Transactions::Disbursement.new(entry_params)
      # authorize @entry
      if @entry.save
        redirect_to accounting_petty_cash_index_url, notice: "entry Recorded successfully"
      else
        render :new
      end
    end

    def show
      @entry = Entry.find(params[:id])
    end

    private
    def entry_params
      params.require(:transactions_disbursement).permit(:date, :reference_number, :entriable_id, :entriable_type, :description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
