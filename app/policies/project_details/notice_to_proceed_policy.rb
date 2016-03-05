class ProjectDetails::NoticeToProceedPolicy < ApplicationPolicy
  attr_reader :user, :notice_to_proceed

  def initialize(user, notice_to_proceed)
    @user = user
    @notice_to_proceed = notice_to_proceed
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

