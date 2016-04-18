class WorkDetails::EmploymentsController < ApplicationController

 def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @employment = @work_detail.employments.build
    authorize @employment
  end

  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @employment = @work_detail.employments.create(employment_params)
    authorize @employment
    if @employment.save
      redirect_to new_work_detail_employment_url(@work_detail), notice: 'Employee has been added succesfully.'
    else
      render :new
    end
  end

  def destroy
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @employment = Employment.find(params[:id])
    authorize @employment
    @employment.destroy
    redirect_to @employment.work_detail, notice: 'Employee has been removed succesfully.'
  end

  private
    def employment_params
      params.require(:employment).permit(:employee_id, :project_id)
    end
end
