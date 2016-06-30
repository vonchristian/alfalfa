module Supplies
  class InventoriesController < ApplicationController
    layout 'supplies'
    def index
      authorize User
      if params[:name].present?
        @inventories = Supplies::Inventory.search_by_name(params[:name]).order(:created_at).page(params[:page]).per(50)
      else
        @inventories = Supplies::Inventory.all.order(:name).page(params[:page]).per(50)
      end
    end
    def available
      @inventories = Supplies::Inventory.available.page(params[:page]).per(50)
    end
    def out_of_stock
      @inventories = Supplies::Inventory.unavailable.page(params[:page]).per(50)
    end
    def discontinued
      @inventories = Supplies::Inventory.discontinued.page(params[:page]).per(50)
    end

    def new
      @inventory = Supplies::Inventory.new
      authorize @inventory
      @inventory.stocks.build
    end

    def create
      @inventory = Supplies::Inventory.create(inventory_params)
      authorize @inventory
      if @inventory.save
        @inventory.available!
        @inventory.create_activity :create, owner: current_user
        redirect_to supplies_inventories_url, notice: "Inventory saved successfully."
      else
        render :new
      end
    end

    def show
      @inventory = Supplies::Inventory.find(params[:id])
      authorize @inventory
    end

    def edit
      @inventory = Supplies::Inventory.find(params[:id])
      authorize @inventory
    end

    def update
      @inventory = Supplies::Inventory.find(params[:id])
      authorize @inventory
      if @inventory.update(inventory_params)
        redirect_to supplies_inventories_url, notice: 'Inventory updated successfully.'
      else
        render :edit
      end
    end

    def destroy
      @inventory = Supplies::Inventory.find(params[:id])
      if @inventory.destroy
        redirect_to supplies_inventories_url, notice: 'Item successfully deleted.'
      end
    end

    def discontinue
      @inventory = Supplies::Inventory.find(params[:id])
      @inventory.discontinue
      redirect_to supplies_inventories_url, notice: "Inventory discontinued successfully."
    end
    
    def continue
      @inventory = Supplies::Inventory.find(params[:id])
      @inventory.unavailable!
      redirect_to supplies_inventories_url, notice: "Inventory continued successfully."
    end

    private
    def inventory_params
      params.require(:supplies_inventory).permit( :name, :item_category_id, :description, :price, :unit, stocks_attributes:[:date, :quantity, :unit_cost, :total_cost])
    end
  end
end
