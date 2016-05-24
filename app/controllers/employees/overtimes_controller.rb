module Employees
  class OvertimesController < ApplicationController
    layout "accounting"
    def new
      @employee = Employee.find(params[:employee_id])
      @overtime = @employee.overtimes.build
    end
    def create
      @employee = Employee.find(params[:employee_id])
      @overtime = @employee.overtimes.create(overtime_params)
      if @overtime.save
        redirect_to @employee, notice: "Overtime saved successfully."
      else
        render :new
      end
    end

    private
    def overtime_params
      params.require(:accounting_employees_overtime).permit(:number_of_hours, :start_date, :end_date)
    end
  end
end
