module Monitoring
  class WorkAccomplishmentsController < ApplicationController
    layout "monitoring"
    def new
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @work_accomplishment = @work_detail.work_accomplishments.build
    end

    def create
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @work_accomplishment = @work_detail.work_accomplishments.create(work_accomplishment_params)
      @work_accomplishment.recorder = current_user
      if @work_accomplishment.save
        @work_accomplishment.unpaid!
         @work_accomplishment.create_activity :create, owner: current_user, recipient: @work_detail.project
        redirect_to monitoring_work_detail_path(@work_detail), notice: "Work accomplishment saved successfully."
      else
        render :new
      end
    end

    private
    def work_accomplishment_params
      params.require(:work_accomplishment).permit(:quantity, :date_accomplished, :remarks)
    end
  end
end
