class ProjectBillingsController < ApplicationController 
	def new 
		@project = Project.find(params[:project_id])
		@project_billing = @project.project_billings.build
	end

	def create
		@project = Project.find(params[:project_id])
		@project_billing = @project.project_billings.create(project_billing_params)
		if @project_billing.save 
			redirect_to @project, notice: "success"
		else
			render :new
		end
	end

	private 
	def project_billing_params
		params.require(:project_billing).permit(billings_attributes: [:id, :quantity, :inventory_id, :_destroy])
	end
end

