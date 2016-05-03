class Supplies::OrdersController < ApplicationController
  layout 'supplies'
  def index
    @orders = Supplies::Order.all
  end
  def new
    @cart = current_cart
      if @cart.line_items.empty?
        redirect_to store_url, notice: "Your cart is empty"
      return
    end
    @order = Supplies::Order.new
  end
  def create
    @order = Supplies::Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Supplies::Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to supplies_url, notice:
        'Thank you for your order.' }
        format.json { render json: @order, status: :created,
        location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors,
        status: :unprocessable_entity }
      end
    end
  end

  def show
    @order = Supplies::Order.find(params[:id])
  end

  private
  def order_params
    params.require(:supplies_order).permit(:customer_id, :customer_type)
  end
end
