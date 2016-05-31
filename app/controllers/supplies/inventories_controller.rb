module Supplies
  class InventoriesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    layout 'supplies'
    def index
      @inventories = Supplies::Inventory.all.order('created_at DESC').page(params[:page]).per(50)
      authorize @inventories, :index?
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
        # @inventory.update_accounts
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

    private
    def inventory_params
      params.require(:supplies_inventory).permit( :name, :description, :price, :unit, stocks_attributes:[:date, :quantity, :unit_cost, :total_cost])
    end
    def record_not_found
      redirect_to after_sign_in_path_for(current_user), alert: "We're sorry but the page you were looking for could not be found."
    end
  end
end
