class Assets::EntriesController < ApplicationController
 
  def new
    @asset = Plutus::Asset.find(params[:asset_id])
    @entry = Plutus::Entry.new
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @asset = Plutus::Asset.find(params[:d])
    @entry = Plutus::Entry.new(entry_params)
    if @entry.save
      redirect_to @asset, notice: "entry Recorded successfully"
    else
      render :new
    end
  end
  
  def show
    @entry = Plutus::Entry.find(params[:id])
  end
  private
  def entry_params
    params.require(:entry).permit(:description, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
