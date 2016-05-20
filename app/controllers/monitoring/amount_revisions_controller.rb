module Monitoring
  class AmountRevisionsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @amount_revisions = @project.amount_revisions
      authorize User
    end

    def new
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @amount_revision = @work_detail.amount_revisions.build
      authorize @amount_revision
    end

    def create
      @work_detail = WorkDetail.find(params[:work_detail_id])
      @amount_revision = @work_detail.amount_revisions.create(amount_revision_params)
      authorize @amount_revision
      @amount_revision.recorder = current_user
      if @amount_revision.save
        redirect_to monitoring_work_detail_url(@work_detail), notice: "Amount Revision saved successfully."
      else
        render :new
      end
    end

    private
    def amount_revision_params
      params.require(:change_orders_amount_revision).permit(:amount, :date, :remarks, :quantity)
    end
  end
end
