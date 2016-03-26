class ContractPolicy < ApplicationPolicy

 attr_reader :current_user, :contract

  def initialize(user, contract)
    @user = user
    @contract = contract
  end

  def show?
    true
  end

  def create?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer?
  end

  def edit?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer?
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
