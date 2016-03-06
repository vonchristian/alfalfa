class PettyCash::FundTransfersController < ApplicationController

  def new
    @petty_cash = Asset.find_by_name!("Petty Cash")
    @fund_transfer = FundTransfer.new
  end

  def create
    @petty_cash = Asset.find_by_name!("Petty Cash")
    @fund_transfer =FundTransfer.create(fund_transfer_params)
    @fund_transfer.recipient_account_id = @petty_cash.id
    if @fund_transfer.save
      @fund_transfer.update_accounts
      redirect_to petty_cash_index_path, notice: "Fund transfer recorded successfully"
    else
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end
  private
  def fund_transfer_params
    params.require(:fund_transfer).permit(:source_account_id, :recipient_account_id, :date, :amount)
  end
end
