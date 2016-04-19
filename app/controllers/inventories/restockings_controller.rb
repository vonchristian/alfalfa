class Inventories::RestockingsController < ApplicationController
  def new
    @inventory = Inventory.find(params[:inventory_id])
    @restocking = @inventory.restockings.build
  end

  def create
    @inventory = Inventory.find(params[:inventory_id])
    @restocking = @inventory.restockings.create(restocking_params)
    if @restocking.save
      redirect_to @inventory, notice: "Inventory restocked successfully."
    else
      render :new
    end
  end

  private
  def restocking_params
    params.require(:restocking).permit(:quantity, :price, :total_cost)
  end
end
