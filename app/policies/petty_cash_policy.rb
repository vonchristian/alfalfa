class PettyCashPolicy < ApplicationPolicy
  attr_reader :user, :petty_cash

  def initialize(user, petty_cash)
    @user = user
    @petty_cash = petty_cash
  end

  def show?
      user.accounting_officer?
    end

end
