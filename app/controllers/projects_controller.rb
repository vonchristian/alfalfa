class ProjectsController < ApplicationController
  def index
    @projects =ProjectDecorator.decorate_collection(Project.all)
  end
  def detailed
   @projects =ProjectDecorator.decorate_collection(Project.all)
  end
  def search
  end
  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if  @project.save
      @project.create_activity :create, owner: current_user
    redirect_to @project, notice: "Project successfully saved."
  else 
    render :new 
  end
  end

  def show
    @project = Project.find(params[:id]).decorate
  end

  private
  def project_params
    params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :category_id)
  end
end
