class SuppliesController < ApplicationController
  layout 'supplies'
  def index
    if params[:name].present?
      @inventories = Inventory.search_by_name(params[:name])
    else
      @inventories = Inventory.all
    end
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end
end
