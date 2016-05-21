module Supplies
  class InventoriesController < ApplicationController
    layout 'supplies'
    def index
      @inventories = Supplies::Inventory.all.order('created_at DESC').page(params[:page]).per(10)
    end

    def new
      @inventory = Supplies::Inventory.new
      @inventory.stocks.build
    end

    def create
      @inventory = Supplies::Inventory.create(inventory_params)
      if @inventory.save
        # @inventory.update_accounts
        @inventory.create_activity :create, owner: current_user
        redirect_to supplies_inventories_url, notice: "Inventory saved successfully."
      else
        render :new
      end
    end

    def show
      @inventory = Supplies::Inventory.find(params[:id])
    end

    def edit
      @inventory = Supplies::Inventory.find(params[:id])
    end

    def update
      @inventory = Supplies::Inventory.find(params[:id])
      if @inventory.update(inventory_params)
        redirect_to supplies_inventories_url, notice: 'Inventory updated successfully.'
      else
        render :edit
      end
    end

    private
    def inventory_params
      params.require(:supplies_inventory).permit( :name, :description, :price, :unit, stocks_attributes:[:date, :quantity])
    end
  end
end
