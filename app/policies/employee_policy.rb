class EmployeePolicy < ApplicationPolicy

 attr_reader :user, :employee

  def initialize(user, employee)
    @user = user
    @employee = employee
  end

  def show?
    true
  end

  def create?
  user.accounting_officer?
  end

  def edit?
    user.accounting_officer?
  end

  def update?
    edit?
  end

  def new?
    create?
  end

  def destroy?
    edit?
  end
end
