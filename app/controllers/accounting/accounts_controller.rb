class Accounting::AccountsController < ApplicationController
  layout "accounting"
  def index
    if params[:name].present?
      @accounts = Account.search_by_name(params[:name])
    else
      @accounts = Account.all.order(:type)
    end
  end
  def new
    @account = Account.new
  end

  def create
    @accounts = Account.all.order(:type)
    @account = Account.create(account_params)
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @accounts = Account.all
    @account = Account.find(params[:id])

    @account.update_attributes(account_params)
  end

  def show
    @account = Account.find(params[:id])
  end

  def income_statement
  end

  private
  def account_params
    params.require(:account).permit(:code, :name, :type, :contra)
  end
  end
