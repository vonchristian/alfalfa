class BalanceSheetPolicy < Struct.new(:user, :accounting)
  attr_reader :user, :balance_sheet

  def initialize(user, balance_sheet)
    @user = user
    @balance_sheet = balance_sheet
  end

  def show?
      user.accounting_officer?
    end

end
