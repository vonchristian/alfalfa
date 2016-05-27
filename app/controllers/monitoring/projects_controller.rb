module Monitoring
  class ProjectsController < ApplicationController
    layout "monitoring"
    def index
      if params[:name].present?
        @projects = Project.search_by_name(params[:name]).order(:created_at).decorate
        respond_to do |format|
          format.html # index.html.erb
          format.pdf do
            pdf = ContractSummaryReportPdf.new(@projects, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Income Statement.pdf"
          end
        end
      else
        @projects = ProjectDecorator.decorate_collection(Project.all.order(:created_at).reverse)
        respond_to do |format|
          format.html # index.html.erb
          format.pdf do
            pdf = ContractSummaryReportPdf.new(@projects, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Income Statement.pdf"
          end
        end
      end
      authorize User
    end

    def new
      @project = Project.new
      authorize @project
    end
    def create
      @project = Project.create(project_params)
      authorize @project
      if @project.save
        redirect_to monitoring_project_path(@project), notice: "Project saved successfully."
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
      @project.update(project_params)
      if @project.save
        redirect_to monitoring_project_url(@project), notice: "Project updated successfully."
      else
        render :edit
      end
    end

    def show
      @project = Project.find(params[:id]).decorate
      authorize @project
    end

    private
    def project_params
      params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :project_type, :implementing_office)
    end
  end
end
