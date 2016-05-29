class AccountingPolicy < Struct.new(:user, :accounting)
  attr_reader :user, :accounting

  def initialize(user, post)
    @user = user
    @accounting = accounting
  end

  def show?
      user.accounting_officer?
    end
end
