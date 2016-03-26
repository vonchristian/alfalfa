class CollectionPolicy < ApplicationPolicy

 attr_reader :current_user, :collection

  def initialize(user, collection)
    @user = user
    @collection = collection
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
    user.project_engineer? || user.monitoring_officer? || user.liason_officer?
  end
end
