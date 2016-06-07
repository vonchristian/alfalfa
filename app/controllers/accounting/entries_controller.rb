module Accounting
  class EntriesController < ApplicationController
    layout "accounting"

    def index
      if params[:query].present?
        @entries = Entry.search_by_query(params[:query]).order(:created_at).page(params[:page]).per(30)
        authorize @entries, :index?
      else
        @entries = Entry.all.order('date DESC').page(params[:page]).per(30)
        authorize @entries, :index?
        @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
        @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
        respond_to do |format|
          format.html
          format.pdf do
            pdf = EntriesPdf.new(@entries, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Entries Report.pdf"
          end
        end
      end
    end
    def scope_to_date
      @entries = Accounting::Entry.created_between(params[:from_date], params[:to_date]).page(params[:page]).per(50)
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PettyCashPdf.new(@entries, @from_date, @to_date, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Entries Report.pdf"
        end
      end
    end


    def new
      @entry = Accounting::Entry.new
      authorize @entry
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end

    def create
      @entry = Accounting::Entry.new(entry_params)
      authorize @entry
      if @entry.save
        redirect_to accounting_entries_path, notice: "Entry saved successfully."
      else
        render :new
      end
    end

    def show
      @entry = Accounting::Entry.find(params[:id])
      authorize @entry
    end

    def edit
      @entry = Accounting::Entry.find(params[:id])
    end

    def update
      @entry = Accounting::Entry.find(params[:id])
      authorize @entry
      @entry.update(entry_params)
      if @entry.save
        redirect_to accounting_entry_path(@entry), notice: "Entry updated successfully."
      else
        render :edit
      end
    end
    private
    def entry_params
      params.require(:accounting_entry).permit(:description, :entry_type,  :date, :reference_number, :entriable_id, :entriable_type, :credit_amounts_attributes=> [:id, :amount, :account],:debit_amounts_attributes=> [:id, :amount, :account])
    end
  end
end
