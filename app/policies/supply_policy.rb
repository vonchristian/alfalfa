class SupplyPolicy < ApplicationPolicy
  attr_reader :user, :supply

  def initialize(user, supply)
    @user = user
    @supply = supply
  end

  def show?
      user.supply_officer?
    end

end
