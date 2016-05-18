class Employees::WorkedDaysController < ApplicationController
  layout "accounting"
  def new
    @employee = Employee.find(params[:employee_id])
    @worked_day = @employee.worked_days.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @worked_day = @employee.worked_days.create(worked_day_params)
    if @worked_day.save
      @worked_day.set_to_unpaid!
      redirect_to @employee, notice: "Number of days worked saved successfully."
    else
      render :new
    end
  end

  private
  def worked_day_params
    params.require(:worked_day).permit(:number_of_days, :start_date, :end_date, :project_id)
  end
end
