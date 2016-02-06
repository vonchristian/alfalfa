class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order('created_at DESC')
  end
  def search
  end
  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      redirect_to @project, notice: "Project successfully created"
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private
  def project_params
    params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :classification)
  end
end
