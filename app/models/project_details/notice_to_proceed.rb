class ProjectDetails::NoticeToProceed < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project
  validates :date, presence: true
  validates_datetime :date, on_or_after: :project_created_at, on_or_after_message: "Must be after the date project was created"

  delegate :created_at, to: :project, prefix: true
end
