class AccountingController < ApplicationController
  layout "accounting"
  def index
    @entries = Accounting::Entry.all.order('date DESC').page(params[:page]).per(10)
    authorize :accounting, :show?
  end
end
