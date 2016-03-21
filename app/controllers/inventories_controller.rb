class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def new
    @inventory = Inventory.new
    authorize @inventory
  end

  def create
    authorize @inventory
    @inventory = Inventory.create(inventory_params)
    if @inventory.save
      @inventory.create_activity :create, owner: current_user
      redirect_to inventories_url, notice: "Inventory saved successfully."
    else
      render :new
    end
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    authorize @inventory
    if @inventory.update
      redirect_to inventories_url, notice: 'Inventory updated successfully.'
    else
      render :edit
    end
  end

  private
  def inventory_params
    params.require(:inventory).permit(:cost, :quantity, :name, :description, :unit)
  end
end
