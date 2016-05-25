class PayrollController < ApplicationController
  layout "accounting"
	def index
		@employees = Employee.all.order('last_name DESC').page(params[:page]).per(10)
		respond_to do |format|
			format.html
			format.pdf do
		    pdf = PayrollPdf.new(@employees, view_context)
		    send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Payroll Summary Report.pdf"
			end
		end
	end

	def show
		@employee = Employee.find(params[:id])
	end
end
