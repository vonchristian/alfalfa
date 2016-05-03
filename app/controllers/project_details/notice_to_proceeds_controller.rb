class ProjectDetails::NoticeToProceedsController < ApplicationController
  # before_action :set_notice_to_proceed, only: [:edit, :update]
layout "projects"
  def new
    @project = Project.find(params[:project_id])
    @notice_to_proceed = @project.build_notice_to_proceed
    authorize @notice_to_proceed
  end

  def edit
    @project = Project.find(params[:project_id])
    @notice_to_proceed = @project.build_notice_to_proceed
    authorize @notice_to_proceed
  end

  def create
    @project = Project.find(params[:project_id])
    @notice_to_proceed = @project.create_notice_to_proceed(notice_to_proceed_params)
    authorize @notice_to_proceed
    if @notice_to_proceed.save
     @notice_to_proceed.create_activity :create, owner: current_user, recipient: @project
      redirect_to @project, notice: "Notice to Proceed date of award saved successfully."
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @notice_to_proceed = ProjectDetails::NoticeToProceed.find(params[:id])
    authorize @notice_to_proceed
     @notice_to_proceed.update(notice_to_proceed_params)
     if @notice_to_proceed.save
      @notice_to_proceed.create_activity :update, owner: current_user, recipient: @project
      redirect_to @notice_to_proceed.project, notice: "Notice to Proceed date of award updated successfully."
    else
      render :edit
    end
  end

  private

  def notice_to_proceed_params
    params.require(:project_details_notice_to_proceed).permit(:date)
  end
end
