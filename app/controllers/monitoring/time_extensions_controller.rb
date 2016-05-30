module Monitoring
  class TimeExtensionsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @time_extensions = @project.time_extensions
      authorize User
    end

    def new
      @project = Project.find(params[:project_id])
      @time_extension = @project.time_extensions.build
      authorize @time_extension
    end

    def create
      @project = Project.find(params[:project_id])
      @time_extension = @project.time_extensions.create(time_extension_params)
      authorize @time_extension
      @time_extension.recorder = current_user
      if @time_extension.save
        redirect_to monitoring_project_url(@project), notice: "Time Extension saved successfully."
      else
        render :new
      end
    end

    private
    def time_extension_params
      params.require(:change_orders_time_extension).permit(:number_of_days, :date, :remarks)
    end
    end
    end
