class ProjectPolicy < ApplicationPolicy
  attr_reader :current_user, :project

  def initialize(current_user, project)
    @current_user = current_user
    @project = project
  end

  def create?
  current_user.project_engineer?
  end

  def new?
    create?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

