class EquipmentExpensePolicy < ApplicationPolicy
  attr_reader :current_user, :equipment_expense

  def initialize(user, equipment_expense)
    @user = user
    @equipment_expense = equipment_expense
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
