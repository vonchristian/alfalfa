module Supplies
  class StocksController < ApplicationController
    layout 'supplies'
    def new
      @inventory = Supplies::Inventory.find(params[:inventory_id])
      @stock = @inventory.stocks.build
    end

    def create
      @inventory = Supplies::Inventory.find(params[:inventory_id])
      @stock = @inventory.stocks.create(stock_params)
      if @stock.save
        redirect_to @inventory, notice: "New stock saved successfully."
      else
        render :new
      end
    end

    private
    def stock_params
      params.require(:stock).permit(:quantity, :date)
    end
  end
end
