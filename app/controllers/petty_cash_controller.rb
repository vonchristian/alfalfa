class PettyCashController < ApplicationController
  layout "accounting"
  def index
    @petty_cash = Account.find_by_name("Petty Cash")
    @disbursements = Disbursement.all
  end
end
