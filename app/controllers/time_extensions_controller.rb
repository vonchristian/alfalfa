class TimeExtensionsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @time_extension = @project.time_extensions.build
    authorize @time_extension
  end

  def create
    @project = Project.find(params[:project_id])
    @time_extension = @project.time_extensions.create(time_extension_params)
    authorize @time_extension
    if @time_extension.save
      redirect_to @project, notice: "Project extended for #{@time_extension.number_of_days} days."
    else
      render :new
    end
  end

  private
  def time_extension_params
    params.require(:change_orders_time_extension).permit(:number_of_days, :remarks)
  end
end
