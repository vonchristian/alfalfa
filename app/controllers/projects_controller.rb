class ProjectsController < ApplicationController
  layout "projects"
  before_action :set_project_type
  decorates_assigned :project

  def index
    @projects =Project.all
    authorize @projects
  end

  def overview
   @projects =ProjectDecorator.decorate_collection(Project.all)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.create(project_params)
    authorize @project
    if @project.save
      @project.create_contract
      redirect_to @project, notice: "Project was successfully saved."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    authorize @project
    if @project.update(project_params)
      @project.update_contract
      redirect_to @project, notice: "Project updated successfully."
    else
      render :edit
    end
  end


  def show
    @project = Project.find(params[:id]).decorate
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

  def payroll
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
         pdf = ProjectPayrollPdf.new(@project, @project.employees, view_context)
        send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Payroll.pdf"
      end
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :project_type, :implementing_office, {:item_ids=>[] }, { :employee_ids =>[] })
  end

  def set_project_type
    @project_type = type
  end

  def type
    Project.types.include?(params[:type]) ? params[:type] : "Project"
  end

  def type_class
    type.constantize
  end

end
