module Monitoring
  class PaymentsController < ApplicationController
    layout "monitoring"
    def index
      @projects = Project.all
    end
    def new
      @project = Project.find(params[:project_id])
      @entry = Accounting::Entry.new
      @entry.debit_amounts.build
      @entry.credit_amounts.build
    end
    def create
      @project = Project.find(params[:project_id])
      @entry = Accounting::Entry.new(entry_params)
      @entry.entriable = @project
      if @entry.save
        redirect_to @asset, notice: "Entry Recorded successfully"
      else
        render :new
      end
    end
    def show
      @project = Project.find(params[:project_id])
    end

    private
    def entry_params
      params.require(:accounting_entry).permit(:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
