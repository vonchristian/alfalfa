class ChangeOrders::TimeExtensionPolicy < ApplicationPolicy

 attr_reader :current_user, :time_extension

  def initialize(user, time_extension)
    @user = user
    @time_extension = time_extension
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
