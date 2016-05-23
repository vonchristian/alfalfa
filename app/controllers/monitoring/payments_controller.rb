module Monitoring
  class PaymentsController < ApplicationController
    layout "monitoring"
    def index
      @projects = Project.all
    end
    def new
      @project = Project.find(params[:project_id])
      @entry = Transactions::InvoicePayment.new
      @entry.debit_amounts.build
      @entry.credit_amounts.build
    end
    def create
      @project = Project.find(params[:project_id])
      @entry = Transactions::InvoicePayment.create(payment_params)
      @entry.entriable = @project
      if @entry.save
        redirect_to @asset, notice: "Invoice payment recorded successfully"
      else
        render :new
      end
    end
    def show
      @project = Project.find(params[:project_id])
    end

    private
    def payment_params
      params.require(:transactions_invoice_payment).permit(:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
