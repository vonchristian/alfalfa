class WorkersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @worker = @project.workers.build
    @worker.materials.build
  end

  def create
    @project = Project.find(params[:project_id])
    @worker = @project.workers.build(worker_params)
    if @worker.save

      redirect_to @project, notice: "workeror added successfully to project."
    else
      render :new
    end
  end

  private
  def worker_params
    params.require(:worker).permit(:employee_id)
  end
end
