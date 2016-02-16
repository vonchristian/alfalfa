class BillableMaterialsController < ApplicationController
  def new
    @project = Project.find(params[:id])
    @billable_material = @project.billable_materials.build
  end

	def create
		@project = Project.find(params[:id])
		@billable_material = @project.billable_materials.create(billable_material_params)
		if @billable_material.save
			redirect_to @project, notice: "Requested material recorded successfully."
		else
			render :new
		end
		end
  private
  def billable_material_params
  	params.require(:billable_material).permit(:inventory_id, :quantity, :contractor_id, :reference_number)
  end
end
