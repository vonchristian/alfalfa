class Projects::WorkDetailsController < ApplicationController
  layout "projects"
  def new
    @project = Project.find(params[:project_id])
    @work_detail = @project.work_details.build
    authorize @work_detail
  end

  def create
    @project = Project.find(params[:project_id])
    @work_detail = @project.work_details.create(work_detail_params)
    authorize @work_detail
    if @work_detail.save
      @work_detail.create_activity :create, owner: current_user, recipient: @project
      redirect_to new_project_work_detail_path(@project), notice: "Work Detail added successfully."
    else
      render :new
    end
  end

  def edit
    @work_detail = WorkDetail.find(params[:id])
    authorize @work_detail
  end

  def update
    @work_detail = WorkDetail.find(params[:id])
    authorize @work_detail
    if @work_detail.update(work_detail_params)
      redirect_to project_path(@work_detail.project), notice: "Work detail updated successfully."
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @work_detail = WorkDetail.find(params[:id])
      authorize @work_detail
    @work_detail.destroy
    redirect_to root_path, notice: "Work Detail has been deleted."
  end

  def show
    @work_detail = WorkDetail.includes(:work_accomplishments).find(params[:id]).decorate
    authorize @work_detail
  end

  private
  def work_detail_params
    params.require(:work_detail).permit(:code, :description, :unit, :unit_cost, :quantity, :total_cost)
  end
end
