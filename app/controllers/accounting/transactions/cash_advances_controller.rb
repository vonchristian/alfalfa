module Accounting
  module Transactions
    class CashAdvancesController < ApplicationController
      def scope_to_date
        @entries = Accounting::Entry.cash_advance.created_between(params[:from_date], params[:to_date])
        @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.zone.now.beginning_of_day
        @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.zone.now.end_of_day
        respond_to do |format|
          format.html
          format.pdf do
            pdf = CashAdvancesPdf.new(@entries, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Entries Report.pdf"
          end
        end
      end
    end
  end
end
