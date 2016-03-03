class EmployeeDetails::EducationalAttainmentsController < ApplicationController
  def new
    @employee = Employee.find(params[:employee_id])
    @educational_attainment = @employee.educational_attainments.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @educational_attainment = @employee.educational_attainments.create(educational_attainment_params)
    if @educational_attainment.save
      redirect_to @employee, notice: "Educational Attainment saved successfully."
    else
      render :new
    end
  end

  private
  def educational_attainment_params
    params.require(:employee_details_educational_attainment).permit(:degree)
  end
end
