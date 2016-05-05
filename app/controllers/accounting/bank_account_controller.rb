module Accounting
  class BankAccountController < ApplicationController
    layout "accounting"
    def index
      @bank_account = Asset.find_by_name("Cash in Bank")
    end
  end
end
