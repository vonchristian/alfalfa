class Transactions::SalaryPaymentPolicy < ApplicationPolicy
  attr_reader :user, :salary_payment

  def initialize(user, salary_payment)
    @user = user
    @salary_payment = salary_payment
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
