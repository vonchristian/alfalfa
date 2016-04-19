class ChangeOrders::AmountRevisionPolicy < ApplicationPolicy

 attr_reader :current_user, :amount_revision

  def initialize(user, amount_revision)
    @user = user
    @amount_revision = amount_revision
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
    user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
  end
end
