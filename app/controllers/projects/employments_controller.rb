class Projects::EmploymentsController < ApplicationController

 def new
    @project = Project.find(params[:project_id])
    @employment = @project.employments.build
  end

  def create
    @project = Project.find(params[:project_id])
    @employment = @project.employments.create(employment_params)
    if @employment.save
      redirect_to new_project_employment_url(@project), notice: 'Employee has been saved succesfully.'
    else
      render :new
    end
  end

  private
    def employment_params
      params.require(:employment).permit(:employee_id)
    end
end
