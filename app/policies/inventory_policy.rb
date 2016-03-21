class InventoryPolicy < ApplicationPolicy
  attr_reader :current_user, :inventory

  def initialize(user, inventory)
    @user = user
    @inventory = inventory
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

