class Projects::ActivitiesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @activities = ActivityDecorator.decorate_collection(PublicActivity::Activity.where(recipient: @project))
  end
end
