class RestockingPolicy < ApplicationPolicy
  attr_reader :current_user, :restocking

  def initialize(user, restocking)
    @user = user
    @restocking = restocking
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

