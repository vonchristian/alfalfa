class FileAttachmentPolicy < ApplicationPolicy

 attr_reader :current_user, :file_attachment

  def initialize(user, file_attachment)
    @user = user
    @file_attachment = file_attachment
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