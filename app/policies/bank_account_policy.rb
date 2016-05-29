class BankAccountPolicy < Struct.new(:user, :accounting)
  attr_reader :user, :bank_account

  def initialize(user, bank_account)
    @user = user
    @bank_account = bank_account
  end

  def show?
      user.accounting_officer?
    end

end
