class PettyCashController < ApplicationController
  def index
    @petty_cash = Account.find_by_name("Petty Cash")
    respond_to do |format|
      format.html
      format.pdf do
         pdf = PettyCashPdf.new(@petty_cash, view_context)
      send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Petty Cash.pdf"

      end
  end
end
end

