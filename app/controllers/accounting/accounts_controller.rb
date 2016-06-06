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
    @account = Account.create(account_params)
    if @account.save
      redirect_to accounting_account_path(@account), notice: "Account created successfully."
    else
      render :new
    end
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
