class AttachmentFilePolicy < ApplicationPolicy

 attr_reader :current_user, :attachment_file

  def initialize(user, attachment_file)
    @user = user
    @attachment_file = attachment_file
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