class EmployeeExpensePolicy < ApplicationPolicy
  attr_reader :current_user, :employee_expense

  def initialize(user, employee_expense)
    @user = user
    @employee_expense = employee_expense
  end

  def index?
    create?
  end

  def show?
   user.accounting_officer?
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
