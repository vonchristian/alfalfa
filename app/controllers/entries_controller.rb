class EntriesController < ApplicationController
  def index
    @entries = Entry.all.order('created_at DESC')
  end
  def new
    @entry = Entry.new
    authorize @entry
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to entries_path, notice: "entry Recorded successfully"
    else
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end
  private
  def entry_params
    params.require(:entry).permit(:description, :entriable, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
