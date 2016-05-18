module Accounting
  class EntriesController < ApplicationController
    layout "accounting"
    def index
      @entries = Entry.all.order('date DESC').page(params[:page]).per(10)
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
