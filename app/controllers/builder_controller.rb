class BuilderController < ApplicationController
  include Wicked::Wizard

 steps :subcontractors


  def show
    @project = Project.find(params[:project_id])
    render_wizard
  end


  def update
    @project = Project.find(params[:project_id])
    @project.update_attributes(params[:project])
    render_wizard @project
  end


  def create
    @project = Project.create
    redirect_to wizard_path(steps.first, :project_id => @project.id)
  end

  def update
    @project = Project.find(params[:project_id])
    params[:project][:status] = 'active' if step == steps.last
    @project.update_attributes(params[:project])
    render_wizard @project
  end
end
