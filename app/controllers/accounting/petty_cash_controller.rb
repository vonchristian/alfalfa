class Accounting::PettyCashController < ApplicationController
  layout "accounting"
  def index
    @petty_cash = Account.find_by_name("Petty Cash")
    @disbursements = Transactions::Disbursement.all.order(:date).reverse
    @fund_transfers = Transactions::FundTransfer.all.order(:date).reverse
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PettyCashPdf.new(@petty_cash,@from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end
end
