class PayrollController < ApplicationController
  layout "accounting"
	def index
		@employees = Employee.all.order('last_name DESC').page(params[:page]).per(10)
	end

	def show
		@employee = Employee.find(params[:id])
	end
end
