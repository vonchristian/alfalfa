class Supplies::LineItemsController < ApplicationController

  def create
    @cart = current_cart
    @line_item = @cart.line_items.create(line_item_params)
    respond_to do |format|
      if @line_item.save
        @cart.add_inventory(@line_item)
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

  def edit
    @line_item = Supplies::LineItem.find(params[:id])
  end

  def update
    @line_item = Supplies::LineItem.find(params[:id])
    @line_item.update_attributes(line_item_update_params)
    @line_item.order.update(:date_issued => @line_item.date)
  end

  def destroy
    @line_item = Supplies::LineItem.find(params[:id])
    @order = @line_item.order
    if request.referrer == supplies_url || request.referrer == supplies_fuel_monitoring_index_url || request.referrer == new_order_url
      @line_item.destroy
      redirect_to supplies_url, notice: 'LineItem has been deleted.'
    else
      if @order.line_items.count > 1
        @line_item.destroy
        redirect_to order_path(@order), notice: 'LineItem has been deleted.'
      elsif @order.line_items.count < 2
        @line_item.destroy
        @order.destroy
        redirect_to orders_url, notice: 'Order has been deleted.'
      end
    end
  end

  private
  def line_item_params
    params.require(:supplies_line_item).permit(:inventory_id, :quantity, :unit_cost, :total_cost)
  end

  def line_item_update_params
    params.require(:supplies_line_item).permit(:inventory_id, :quantity, :unit_cost, :total_cost, :date)
  end
end
