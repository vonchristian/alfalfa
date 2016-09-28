module Supplies
  class FuelMonitoringController < ApplicationController
    layout 'supplies'
    def index
      if params[:name].present?
        @inventories = Supplies::Inventory.search_by_name(params[:name]).order(:name)
      else
        @inventory = Supplies::Inventory.find_by(name: "Diesel")
      end
      @cart = current_cart
      @line_item = Supplies::LineItem.new
      @order = Order.new
    end

    def show
    end
  end
end