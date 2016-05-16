class Accounting::BalanceSheetController < ApplicationController
  layout "accounting"
  def index
    authorize [:accounting, :balance_sheet], :index?
    first_entry = Accounting::Entry.order('date ASC').first
    @from_date = first_entry ? first_entry.date: Date.today
    @to_date = params[:date] ? Date.parse(params[:date]) : Date.today
    @assets = Asset.all
    @liabilities = Liability.all
    @equity = Equity.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
