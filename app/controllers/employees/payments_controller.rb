class Employees::PaymentsController < ApplicationController
  def new
    @employee = Employee.find(params[:employee_id])
    @payment = @employee.payments.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @payment = @employee.payments.create(payment_params)
    if @payment.save
      @payment.create_entry
      redirect_to @employee, notice: "Employee paid successfully."
    else
      render :new
    end
  end

  private
  def payment_params
    params.require(:payment).permit(:amount, :date)
  end
end
