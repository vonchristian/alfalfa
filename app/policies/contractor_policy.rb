class ContractorPolicy < ApplicationPolicy

 attr_reader :current_user, :contractor

  def initialize(user, contractor)
    @user = user
    @contractor = contractor
  end

  def show?
    true
  end

  def create?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
  end

  def edit?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
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
