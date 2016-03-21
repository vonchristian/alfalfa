class IssuedInventoriesController < ApplicationController
  def new
    @issued_inventories = IssuedInventory.all
    @issued_inventory = IssuedInventory.new
    authorize @issued_inventory
  end

  def create
    authorize @issued_inventory
    @issued_inventory = IssuedInventory.create(issued_inventory_params)
    if @issued_inventory.save
      redirect_to new_issued_inventory_url, notice: "Inventory issued successfully."
    else
      render :new
    end
  end

  private
  def issued_inventory_params
    params.require(:issued_inventory).permit(:inventoriable_id, :inventory_id, :quantity, :total_cost)
  end
end
