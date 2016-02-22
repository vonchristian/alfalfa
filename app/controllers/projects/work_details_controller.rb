class Projects::WorkDetailsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @work_detail = @project.work_details.build
  end

  def create
    @project = Project.find(params[:project_id])
    @work_detail = @project.work_details.create(work_detail_params)
    if @work_detail.save
      @work_detail.create_activity :create, owner: current_user, recipient: @project
      redirect_to new_project_work_detail_path(@project), notice: "Work Detail added successfully."
    else
      render :new
    end
  end

  def import
  @project = Project.find(params[:project_id])
      WorkDetail.import(params[:file])
      redirect_to @project, notice: "Work Details imported."

  end

  def show
    @work_detail = WorkDetail.includes(:work_accomplishments).find(params[:id]).decorate
  end
  private
  def work_detail_params
    params.require(:work_detail).permit(:code, :description, :unit, :unit_cost, :quantity, :total_cost)
  end
  end
