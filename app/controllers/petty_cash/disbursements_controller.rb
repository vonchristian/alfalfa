class PettyCash::DisbursementsController < ApplicationController

  def new
    @petty_cash = Asset.find_by_name!("Petty Cash")
    @entry = Entry.new
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @petty_cash = Asset.find_by_name!("Petty Cash")
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to new_petty_cash_disbursement_path(@petty_cash), notice: "entry Recorded successfully"
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
