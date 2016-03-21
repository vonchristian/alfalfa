class ProjectDetails::NoticeToProceed < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project

  # validates :date, :not_before_project_created_at

  def not_before_project_created_at
  	self.date < self.project.created_at
  end
end

