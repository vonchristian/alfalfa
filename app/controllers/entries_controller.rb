class EntriesController < ApplicationController
  def index
    @entries = Plutus::Entry.all.order('created_at DESC')
  end
  def new
    @entry = Plutus::Entry.new
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @entry = Plutus::Entry.new(entry_params)
    if @entry.save
      redirect_to entries_path, notice: "Success Success Success"
    else
      render :new
    end
  end
  def income_statement
      @from_date = params[:from_date] ? Date.parse(params[:from_date]) : Date.today.at_beginning_of_month
      @to_date = params[:to_date] ? Date.parse(params[:to_date]) : Date.today
      @revenues = Plutus::Entry.all

      respond_to do |format|
        format.html # index.html.erb
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
