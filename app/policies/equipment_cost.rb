class EquipmentCostPolicy < ApplicationPolicy

 attr_reader :current_user, :equipment_cost

  def initialize(user, equipment_cost)
    @user = user
    @equipment_cost = equipment_cost
  end

  def show?
    true
  end

  def create?
    user.supply_officer?
  end

  def edit?
    user.supply_officer?
  end

  def update?
    edit?
  end

  def new?
    create?
  end

  def destroy?
    user.supply_officer?
  end
end
