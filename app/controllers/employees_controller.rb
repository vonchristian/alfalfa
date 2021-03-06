class EmployeesController < ApplicationController
	layout "accounting"

	def index
		if params[:name].present?
      @employees = Employee.search_by_name(params[:name]).order('last_name DESC').page(params[:page]).per(30)
    else
			@employees = Employee.all.order('last_name DESC').page(params[:page]).per(50)
		end
    authorize User, :index?
	end

	def new
		@employee = Employee.new
		authorize @employee
	end

	def create
		@employee = Employee.create(employee_params)
		authorize @employee
		if @employee.save
			redirect_to @employee, notice: "Employee added successfully."
		else
			render :new
		end
	end

	def edit
		@employee = Employee.find(params[:id])
		authorize @employee
	end

	def update
		@employee = Employee.find(params[:id])
		authorize @employee
		if @employee.update(employee_params)
			redirect_to @employee, notice: "Updated successfully."
		else
			render :new
		end
	end

	def show
		@employee = Employee.find(params[:id])
	end

 private
	 def employee_params
	 	params.require(:employee).permit(:rate, :first_name, :last_name, :mobile_number, :email, :position, :profile_photo, :employee_type)
	 end
end
