module Monitoring
  class ProjectsController < ApplicationController
    layout "monitoring"
    def index
      if params[:name].present?
        @projects = Project.search_by_name(params[:name]).order(:created_at)
      else
        @projects = Project.all.order(:created_at).reverse
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
      @project = Project.find(params[:id])
      @work_details = @project.work_details.page(params[:page]).per(5)
      authorize @project
    end

    private
    def project_params
      params.require(:project).permit(:name, :cost, :id_number, :duration, :address, :main_contractor_id, :project_type, :implementing_office)
    end
  end
end
