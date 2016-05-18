module Accounting
  class BalanceSheetPolicy < Struct.new(:user, :balance_sheet)
    attr_reader :user, :balance_sheet

    def initialize(user, balance_sheet)
      @user = user
      @balance_sheet = balance_sheet
    end


    def index?
      user.accounting_officer? || user.system_administrator?
    end
  end
end
