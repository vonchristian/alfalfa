module Monitoring
  class WorkAccomplishmentsController < ApplicationController
    layout "monitoring"
    def index
      @work_detail = WorkDetail.find(params[:work_detail_id])
    end

    def new
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @work_accomplishment = @work_detail.work_accomplishments.build
      3.times { @work_accomplishment.accomplishment_images.build }
    end

    def create
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @work_accomplishment = @work_detail.work_accomplishments.create(work_accomplishment_params)
      @work_accomplishment.recorder = current_user
      if @work_accomplishment.save
        @work_accomplishment.pending!
         @work_accomplishment.create_activity :create, owner: current_user, recipient: @work_detail.project
        redirect_to monitoring_work_detail_path(@work_detail), notice: "Work accomplishment saved successfully."
      else
        render :new
      end
    end

    def edit
      @work_accomplishment = WorkAccomplishment.find(params[:id])
    end

    def update
      @work_accomplishment = WorkAccomplishment.find(params[:id])
      @work_accomplishment.update(work_accomplishment_params)
      if @work_accomplishment.save
        redirect_to monitoring_work_detail_work_accomplishments_url(@work_accomplishment.work_detail), notice: "Work Accomplishment updated successfully."
      else
        render :edit
      end
    end

    private
    def work_accomplishment_params
      params.require(:work_accomplishment).permit(:quantity, :date_accomplished, :remarks, accomplishment_images_attributes:[:photo, :caption, :work_accomplishment_id, :id])
    end
  end
end
