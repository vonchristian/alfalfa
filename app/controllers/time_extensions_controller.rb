class TimeExtensionsController < ApplicationController 
  def new 
    @project = Project.find(params[:project_id])
    @time_extension = @project.time_extensions.build
  end

  def create
    @project = Project.find(params[:project_id])
  @time_extension = @project.time_extensions.build(time_extension_params)
    if @time_extension.save 
      redirect_to @project, notice: "Project extended for #{@time_extension.number_of_days} days."
    else
      render :new 
    end
  end

  private 
  def time_extension_params
    params.require(:time_extension).permit(:number_of_days)
  end
end
