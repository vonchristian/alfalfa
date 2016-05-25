module Accounting
  class EntriesController < ApplicationController
    layout "accounting"

    def index
      if params[:query].present?
        @entries = Entry.search_by_query(params[:query]).order(:created_at).page(params[:page]).per(30)
      else
        @entries = Entry.all.order('date DESC').page(params[:page]).per(30)
        @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.zone.now.beginning_of_day
        @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.zone.now.end_of_day
        respond_to do |format|
          format.html
          format.pdf do
            pdf = EntriesPdf.new(@entries, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Entries Report.pdf"
          end
        end
      end
    end

    def new
      @entry = Entry.new
      authorize @entry
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end

    def create
      @entry = Entry.new(entry_params)
      if @entry.save
        redirect_to accounting_entries_path, notice: "Entry saved successfully."
      else
        render :new
      end
    end

    def show
      @entry = Entry.find(params[:id])
    end

    def edit
      @entry = Entry.find(params[:id])
    end

    def update
      @entry = Entry.find(params[:id])
      @entry.update(entry_params)
      if @entry.save
        redirect_to @entry, notice: "Entry updated successfully."
      else
        render :edit
      end
    end
    private
    def entry_params
      params.require(:accounting_entry).permit(:description,  :date, :reference_number, :entriable_id, :entriable_type,
                                    :credit_amounts_attributes=> [:amount, :account],
                                    :debit_amounts_attributes=> [:amount, :account])
    end
  end
end
