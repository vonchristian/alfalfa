class Projects::AssignProjectEngineersController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @worker = @project.workers.build
  end
end