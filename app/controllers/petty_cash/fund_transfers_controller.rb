class PettyCash::FundTransfersController < ApplicationController

  def new
    @petty_cash = Asset.find_by_name!("Petty Cash")
    @entry = Entry.new
    authorize @entry
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @petty_cash = Asset.find_by_name!("Petty Cash")
    @entry = Entry.new(entry_params)
    authorize @entry
    if @entry.save
      redirect_to petty_cash_index_path, notice: "entry Recorded successfully"
    else
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end
  
  private
  def entry_params
    params.require(:entry).permit(:date, :description, :recipient_id, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
