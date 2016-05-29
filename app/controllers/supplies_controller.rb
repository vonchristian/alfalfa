class SuppliesController < ApplicationController
  layout 'supplies'
  def index
    if params[:name].present?
      @inventories = Supplies::Inventory.search_by_name(params[:name])
    else
      @inventories = Supplies::Inventory.all
    end
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def show
  end
end
