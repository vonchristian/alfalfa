module Monitoring
  module Contracts
    class PaymentsController < ApplicationController
      layout "monitoring"
      def new
        @contract = Contract.find(params[:contract_id])
        @project = @contract.project
        @entry = Transactions::ContractorInvoicePayment.new
        @entry.debit_amounts.build
        @entry.credit_amounts.build
      end
      def create
        @contract = Contract.find(params[:contract_id])
        @project = @contract.project
        @entry = Transactions::ContractorInvoicePayment.create(payment_params)
        @entry.entriable = @contract
        if @entry.save
          redirect_to monitoring_contract_url(@contract), notice: "Invoice payment recorded successfully"
        else
          render :new
        end
      end
      def show
        @project = Project.find(params[:project_id])
      end

      private
      def payment_params
        params.require(:transactions_contractor_invoice_payment).permit(:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
      end
    end
  end
end
