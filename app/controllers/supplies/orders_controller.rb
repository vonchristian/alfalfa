class Supplies::OrdersController < ApplicationController
  layout 'supplies'

  def index
    if params[:query].present?
      @orders  = Supplies::Order.text_search(params[:query]).order(:created_at).page(params[:page]).per(50)
    else
      @orders = Supplies::Order.all.order("date_issued desc").page(params[:page]).per(50)
    end
    authorize @orders, :index?
  end

  def projects
    @orders = Supplies::Order.for_projects
  end
  def contractors
    @orders = Supplies::Order.for_contractors
  end
  def customers
    @orders = Supplies::Order.for_customers
  end

  def new
    @cart = current_cart
    @inventory = Supplies::Inventory.find_by(name: "Diesel")
      if @cart.line_items.empty?
        if @inventory.id == @order.line_items.first.inventory_id
          format.html { redirect_to supplies_fuel_monitoring_index_path, notice: 'Your cart is empty.' }
          format.js   { @current_item = @line_item }
        else
          format.html { redirect_to supplies_url, notice: 'Your cart is empty.' }
          format.js   { @current_item = @line_item }
        end
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
    params.require(:supplies_order).permit(:date_issued, :project_id, :name, :customer_id, :customer_type, :payment_status,
      entry_attributes: [:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account]])
  end
end
