class WorkDetails::AmountRevisionsController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @amount_revision = @work_detail.amount_revisions.build
    authorize @amount_revision
  end

  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @amount_revision = @work_detail.amount_revisions.create(amount_revision_params)
    authorize @amount_revision
    if @amount_revision.save
      redirect_to @work_detail, notice: "Amount revision saved successfully."
    else
      render :new
    end
  end

  private
  def amount_revision_params
    params.require(:change_orders_amount_revision).permit(:amount, :remarks, :date)
  end
end
