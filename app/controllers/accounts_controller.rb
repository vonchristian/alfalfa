class AccountsController < ApplicationController
  def index
      @accounts = Plutus::Account.all
  end

  def new
    @account = Plutus::Account.new
  end

  def create
    @account = Plutus::Account.create(account_params)
    if @account.save
      redirect_to @account, notice: "Created successfully"
    else
      render :new
    end
  end

  def show
    @account = Plutus::Account.find(params[:id])
  end

  private
  def account_params
    params.require(:account).permit(:name, :type)
  end
end
