class IssuedInventoriesController < ApplicationController

  def index
    @issued_inventories = IssuedInventory.all
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
    @project = params[:project_id]
    respond_to do |format|
      format.html
      format.pdf do
        pdf = IssuedInventoryPdf.new(@issued_inventories, @project, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end

  def new
    @issued_inventories = IssuedInventory.all
    @issued_inventory = IssuedInventory.new
    authorize @issued_inventory
  end

  def create
    @issued_inventory = IssuedInventory.create(issued_inventory_params)
    authorize @issued_inventory
    @issued_inventory.inventoriable = @project
    if @issued_inventory.save
      redirect_to new_issued_inventory_url, notice: "Inventory issued successfully."
    else
      render :new
    end
  end

  private
  def issued_inventory_params
    params.require(:issued_inventory).permit(:project_id, :inventoriable_id, :contractor_id, :inventory_id, :quantity, :unit_cost, :total_cost, :date_issued)
  end
end
