class Contractors::IssuedInventoriesController < ApplicationController
	
	def show
    @issued_inventories = IssuedInventory.all
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
    @project = (params[:inventoriable_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = IssuedInventoryPdf.new(@issued_inventories, @project, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end

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
		params.require(:issued_inventory).permit(:project_id, :inventory_id, :quantity, :total_cost, :unit_cost, :date_issued)
	end
end

