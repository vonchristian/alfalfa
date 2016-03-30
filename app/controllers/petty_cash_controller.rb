class PettyCashController < ApplicationController
  def index 
    @petty_cash = Account.find_by_name("Petty Cash")
  	@from_date = params[:from_date] ? Date.parse(params[:from_date]) : Date.today.beginning_of_day
  	@to_date = params[:to_date] ? Date.parse(params[:to_date]) : Date.today.end_of_day
    respond_to do |format|
      format.html
      format.pdf do
         pdf = PettyCashPdf.new(@petty_cash, @from_date, @to_date, view_context)
      send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Petty Cash.pdf"
      end
  	end
  end
end

