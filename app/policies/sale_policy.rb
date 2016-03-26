class SalePolicy < ApplicationPolicy

 attr_reader :current_user, :sale

  def initialize(user, sale)
    @user = user
    @sale = sale
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
    user.accounting_officer?
  end
end
