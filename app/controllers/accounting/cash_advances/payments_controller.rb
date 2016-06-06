module Accounting
  module CashAdvances
    class PaymentsController < ApplicationController
      layout 'accounting'
      def new
        @cash_advance = Transactions::CashAdvance.find(params[:cash_advance_id])
        @entry = Transactions::CashAdvancePayment.new
        @entry.debit_amounts.build
        @entry.credit_amounts.build
      end
      def create
        @cash_advance = Transactions::CashAdvance.find(params[:cash_advance_id])
        @entry = Transactions::CashAdvancePayment.new(cash_advance_payment_params)
        authorize @entry
        if @entry.save
          redirect_to accounting_entries_path, notice: "Entry saved successfully."
        else
          render :new
        end
      end
      private
      def cash_advance_payment_params
        params.require(:transactions_cash_advance_payment).permit(:description, :type,  :date, :reference_number, :entriable_id, :entriable_type,
        :credit_amounts_attributes=> [:amount, :account],
        :debit_amounts_attributes=> [:amount, :account])
      end
    end
  end
end
