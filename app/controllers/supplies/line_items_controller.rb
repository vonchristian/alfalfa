class Supplies::LineItemsController < ApplicationController
  def create
    @cart = current_cart
    @line_item = @cart.line_items.create(line_item_params)
    respond_to do |format|
      if @line_item.save
        @line_item.set_total_cost
        @cart.add_inventory
        @inventory = Supplies::Inventory.find_by(name: "Diesel")
        if @inventory.id == @line_item.inventory_id
          format.html { redirect_to supplies_fuel_monitoring_index_path }
          format.js   { @current_item = @line_item }
        else
          format.html { redirect_to supplies_url }
          format.js   { @current_item = @line_item }
        end
      else
        format.html { redirect_to supplies_url }
      end
    end
  end

  def destroy
    @line_item = Supplies::LineItem.find(params[:id])
    @line_item.destroy
    redirect_to supplies_url
  end

  private
  def line_item_params
    params.require(:supplies_line_item).permit(:inventory_id, :quantity, :unit_cost, :total_cost)
  end
end
