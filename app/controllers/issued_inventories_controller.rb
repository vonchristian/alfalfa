class IssuedInventoriesController < ApplicationController

  def index
    @issued_inventories = IssuedInventory.all
    @from_date = params[:from_date] ? Date.parse(params[:from_date]) : Date.today.beginning_of_day
    @to_date = params[:to_date] ? Date.parse(params[:to_date]) : Date.today.end_of_day
    respond_to do |format|
      format.html
      format.pdf do
        pdf = IssuedInventoryPdf.new(@issued_inventories, @from_date, @to_date, view_context)
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
    if @issued_inventory.save
      @issued_inventory.update_quantity_of_inventory_on_save
      redirect_to new_issued_inventory_url, notice: "Inventory issued successfully."
    else
      render :new
    end
  end

  private
  def issued_inventory_params
    params.require(:issued_inventory).permit(:inventoriable_id, :inventory_id, :quantity, :total_cost, :date_issued)
  end
end
