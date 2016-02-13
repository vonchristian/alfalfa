class RemarksController < ApplicationController
  def new 
    @project = Project.find(params[:project_id])
    @remark = @project.remarks.build
  end

  def create
    @project = Project.find(params[:project_id])
    @remark = @project.remarks.build(remark_params)
    @remark.remarker = current_user
      if @remark.save 
      redirect_to @project, notice: "Remarks added successfully."
    else
      render :new 
    end
  end

  private 
  def remark_params
    params.require(:remark).permit(:content, :title)
  end
end
