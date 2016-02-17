class AccountsController < ApplicationController
  def balance_sheet
      first_entry = Plutus::Entry.order('date ASC').first
      @from_date = first_entry ? first_entry.date: Date.today
      @to_date = params[:date] ? Date.parse(params[:date]) : Date.today
      @assets = Plutus::Asset.all
      @liabilities = Plutus::Liability.all
      @equity = Plutus::Equity.all

      respond_to do |format|
        format.html # index.html.erb
      end
    end

    # @example
    #   GET /reports/income_statement
    def income_statement
      @from_date = params[:from_date] ? Date.parse(params[:from_date]) : Date.today.at_beginning_of_month
      @to_date = params[:to_date] ? Date.parse(params[:to_date]) : Date.today
      @revenues = Plutus::Revenue.all
      @expenses = Plutus::Expense.all

      respond_to do |format|
        format.html # index.html.erb
      end
    end

  def new
    @account = Plutus::Account.new
  end

  def create
    @account = Plutus::Account.create(account_params)
    if @account.save
      redirect_to @account, notice: "Created successfully"
    else
      render :new
    end
  end






  private
  def account_params
    params.require(:account).permit(:name, :type, :contra)
  end
end
