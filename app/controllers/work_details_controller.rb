class WorkDetailsController < ApplicationController
  def show
    @work_detail = WorkDetail.find(params[:id])
    redirect_to project_work_detail_path(@work_detail.project, @work_detail)
  end

  def edit
     @work_detail = WorkDetail.find(params[:id])
   end
end
