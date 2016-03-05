class WorkDetailPolicy < ApplicationPolicy
  attr_reader :current_user, :work_detail

  def initialize(user, work_detail)
    @user = user
    @work_detail = work_detail
  end



  def index?
    true
  end

  def show?
   true
  end

  def create?
  user.project_engineer? || user.monitoring_officer?
  end

  def new?
    create?
  end

  def edit?
    user.project_engineer? || user.monitoring_officer?
  end

  def update?
    edit?
  end

  def destroy?
    user.project_engineer?
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

