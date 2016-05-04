class Supplies::LineItemsController < ApplicationController
  def create
    @cart = current_cart
    @line_item = @cart.line_items.create(line_item_params)
    respond_to do |format|
      if @line_item.save
        @cart.add_inventory
        format.html { redirect_to supplies_url }
        format.js   { @current_item = @line_item }
      else
        format.html { redirect_to supplies_url }
      end
    end
  end

  def destroy
    @cart = Supplies::LineItem.find(params[:id])
    @cart.destroy
    redirect_to supplies_url
  end

  private
  def line_item_params
    params.require(:supplies_line_item).permit(:inventory_id, :quantity)
  end
end
