class RemarkPolicy < ApplicationPolicy

 attr_reader :current_user, :remark

  def initialize(user, remark)
    @user = user
    @remark = remark
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
