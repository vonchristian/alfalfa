class Supplies::CartsController < ApplicationController
  def show
    begin
    @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to supplies_url, alert: 'The cart you were looking for could not be found.'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cart }
      end
    end
    @order = Order.new
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to supplies_url, notice: "Cart is currently empty"
  end
end
