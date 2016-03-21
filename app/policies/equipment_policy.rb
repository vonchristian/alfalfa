class EquipmentPolicy < ApplicationPolicy
  attr_reader :current_user, :equipment

  def initialize(user, equipment)
    @user = user
    @equipment = equipment
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

