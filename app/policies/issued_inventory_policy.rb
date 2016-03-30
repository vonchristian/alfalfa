class IssuedInventoryPolicy < ApplicationPolicy
  attr_reader :current_user, :issued_inventory

  def initialize(user, issued_inventory)
    @user = user
    @issued_inventory = issued_inventory
  end

  def index?
    true
  end

  def show?
   true
  end

  def create?
    user.supply_officer?
  end

  def new?
    create?
  end

  def edit?
    user.supply_officer?
  end

  def update?
    edit?
  end

  def destroy?
    user.supply_officer?
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

