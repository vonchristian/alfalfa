class Projects::WorkAccomplishmentsController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @work_accomplishment = @work_detail.work_accomplishments.build
  end

  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @work_accomplishment = @work_detail.work_accomplishments.create(work_accomplishment_params)
    if @work_accomplishment.save
      @work_detail.set_status
      redirect_to project_work_detail_path(@work_detail.project, @work_detail), notice: "Work accomplished recorded successfully"
    else
      render :new
    end
  end

  private
  def work_accomplishment_params
    params.require(:work_accomplishment).permit(:quantity)
  end
end
