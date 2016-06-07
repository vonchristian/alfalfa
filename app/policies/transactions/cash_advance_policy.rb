class Transactions::CashAdvancePolicy < ApplicationPolicy
  attr_reader :user, :cash_advance_payment

  def initialize(user, cash_advance_payment)
    @user = user
    @cash_advance_payment = cash_advance_payment
  end

  def index?
    true
  end

  def show?
   true
  end

  def create?
  user.accounting_officer?
  end

  def new?
    create?
  end

  def edit?
    user.accounting_officer?
  end

  def update?
    edit?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    def resolve
      scope
    end
  end
end
