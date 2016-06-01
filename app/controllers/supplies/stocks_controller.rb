module Supplies
  class StocksController < ApplicationController
    layout 'supplies'
    def new
      @inventory = Supplies::Inventory.find(params[:inventory_id])
      @stock = @inventory.stocks.build
      authorize @stock
    end

    def create
      @inventory = Supplies::Inventory.find(params[:inventory_id])
      @stock = @inventory.stocks.create(stock_params)
      authorize @stock
      if @stock.save
        redirect_to @inventory, notice: "New stock saved successfully."
        @inventory.available!
      else
        render :new
      end
    end

    def edit
      @stock = Supplies::Stock.find(params[:id])
    end

    def update
      @stock = Supplies::Stock.find(params[:id])
      @stock.update(stock_params)
      if @stock.save
        redirect_to @stock.inventory, notice: "Stock Updated successfully."
      else
        render :edit
      end
    end

    private
    def stock_params
      params.require(:supplies_stock).permit(:quantity, :date, :unit_cost, :total_cost)
    end
  end
end
