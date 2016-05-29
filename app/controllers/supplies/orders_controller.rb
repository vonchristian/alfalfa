class Supplies::OrdersController < ApplicationController
  layout 'supplies'

  def index
    @orders = Supplies::Order.all.order("date_issued desc").page(params[:page]).per(10)
    authorize @orders, :index?
  end

  def new
    @cart = current_cart
      if @cart.line_items.empty?
        redirect_to supplies_url, notice: "Your cart is empty"
      return
    end
    @order = Supplies::Order.new
    authorize @order
  end

  def create
    @order = Supplies::Order.new(order_params)
    authorize @order
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save!
        Supplies::Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to supplies_url, notice:
        'Thank you for your order.' }
        format.json { render json: @order, status: :created,
        location: @order }
      else
        @cart = current_cart
        format.html { render action: :new }
        format.json { render json: @order.errors,
        status: :unprocessable_entity }
      end
    end
  end

  def show
    @order = Supplies::Order.find(params[:id])
    authorize @order
  end

  private
  def order_params
    params.require(:supplies_order).permit(:date_issued, :project_id, :customer_id, :customer_type, :payment_status,
      entry_attributes: [:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account]])
  end
end
