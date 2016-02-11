class NoticeToProceedsController < ApplicationController 
  def new 
    @project = Project.find(params[:project_id])
    @notice_to_proceed = @project.build_notice_to_proceed
  end

  def create
    @project = Project.find(params[:project_id])
    @notice_to_proceed = @project.create_notice_to_proceed(notice_to_proceed_params)
    if @notice_to_proceed.save 
     @notice_to_proceed.create_activity :create, owner: current_user, recipient: @project
      redirect_to @project, notice: "success"
    else
      render :new 
    end
  end

  private 
  def notice_to_proceed_params
    params.require(:notice_to_proceed).permit(:date)
  end
end
