module Monitoring
  class TimeExtensionsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @time_extensions = @project.time_extensions
      authorize User
    end

    def new
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @time_extension = @work_detail.time_extensions.build
      authorize @time_extension
    end

    def create
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @time_extension = @work_detail.time_extensions.create(time_extension_params)
      authorize @time_extension
      @time_extension.recorder = current_user
      if @time_extension.save
        redirect_to monitoring_work_detail_url(@work_detail), notice: "Time Extension saved successfully."
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
