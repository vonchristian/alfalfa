class ProjectsController < ApplicationController
  decorates_assigned :project
  def add_workers
    @project = Project.find(params[:id])
  end

  def add_cost_code_items
    @project = Project.find(params[:id])
  end

  def index
    @projects =ProjectDecorator.decorate_collection(Project.all.includes(:amount_revisions))
  end
  def overview
   @projects =ProjectDecorator.decorate_collection(Project.all)
  end

  def import
      Project.import(params[:file])
      redirect_to root_url, notice: "Products imported."

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
    @project = Project.includes(:work_accomplishments).find(params[:id]).decorate
   respond_to do |format|
    format.html
    format.pdf do
      if @project.has_no_change_orders?
      pdf = StatementOfWorkAccomplishedPdf.new(@project, view_context)
      send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Statement of Work for #{@project.id_number}.pdf"
    else
       pdf = StatementOfWorkAccomplishedWithChangeOrdersPdf.new(@project, view_context)
      send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Statement of Work for #{@project.id_number}.pdf"
    end
    end
   end
  end

  private
  def project_params
    params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :category_id, :implementing_office, {:item_ids=>[] }, { :employee_ids =>[] })
  end



end
