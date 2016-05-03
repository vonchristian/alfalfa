class InventoriesController < ApplicationController
  layout 'supplies'
  def index
    @inventories = Inventory.all
  end

  def new
    @inventory = Inventory.new
    @inventory.stocks.build
    authorize @inventory
  end

  def create
    @inventory = Inventory.create(inventory_params)
    authorize @inventory
    if @inventory.save
      # @inventory.update_accounts
      @inventory.create_activity :create, owner: current_user
      redirect_to supplies_inventories_url, notice: "Inventory saved successfully."
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
    if @inventory.update(inventory_params)
      redirect_to supplies_inventories_url, notice: 'Inventory updated successfully.'
    else
      render :edit
    end
  end

  private
  def inventory_params
    params.require(:inventory).permit( :name, :description, :price, :unit, stocks_attributes:[:date, :quantity])
  end
end
