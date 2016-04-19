class Contractors::IssuedInventoriesController < ApplicationController
	def new
		@contractor = Contractor.find(params[:contractor_id])
		@issued_inventory = @contractor.issued_inventories.build
	end

	def create
		@contractor = Contractor.find(params[:contractor_id])
		@issued_inventory = @contractor.issued_inventories.create(issued_inventory_params)
		@issued_inventory.inventoriable = @contractor
		if @issued_inventory.save
			redirect_to @contractor, notice: "Issued inventory saved successfully."
		else
			render :new
		end
	end

	private 
	def issued_inventory_params
		params.require(:issued_inventory).permit(:inventory_id, :quantity, :total_cost, :unit_cost, :date_issued)
	end
end

