class Assets::EntriesController < ApplicationController

  def new
    @asset = Asset.find(params[:asset_id])
    @entry = Accounting::Entry.new
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @asset = Asset.find(params[:d])
    @entry = Accounting::Entry.new(entry_params)
    if @entry.save
      redirect_to @asset, notice: "Entry Recorded successfully"
    else
      render :new
    end
  end

  def show
    @entry = Accounting::Entry.find(params[:id])
  end
  private
  def entry_params
    params.require(:accounting_entry).permit(:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
