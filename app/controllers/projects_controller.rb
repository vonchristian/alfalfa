class ProjectsController < ApplicationController
  def add_workers
    @project = Project.find(params[:id])
  end
  def add_cost_code_items
    @project = Project.find(params[:id])
  end
  def index
    @projects =ProjectDecorator.decorate_collection(Project.all)
  end
  def overview
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
        @project.create_activity :create, owner: current_user, trackable: @project
      redirect_to @project, notice: "Project successfully saved."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end
  def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        @project.create_activity :update, owner: current_user, trackable: @project
          redirect_to @project, notice: "Project successfully updated."
      else
          render :edit
      end
  end

  def show
    @project = Project.find(params[:id]).decorate
  end

  private
  def project_params
    params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :category_id, :implementing_office, {:item_ids=>[] }, { :employee_ids =>[] })
  end


end
