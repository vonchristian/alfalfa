class Supplies::OrdersController < ApplicationController
  layout 'supplies'

  def index
    if params[:query].present?
      @orders  = Supplies::Order.text_search(params[:query]).order(date_issued: :desc).page(params[:page]).per(50)
    else
      @orders = Supplies::Order.all.order("date_issued desc").page(params[:page]).per(50)
    end
    authorize @orders, :index?

    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_month
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_month
    @orders = Supplies::Order.filter_with(:customer_id => @customer_id, :from_date => @from_date, :to_date => @to_date).all.page(params[:page]).per(30)
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = OrderLineItemsPdf.new(@orders, @customer_id, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Orders.pdf"
      end
    end
  end

  def over_all
    @inventory_id = params[:inventory_id] if params[:inventory_id].present?
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.parse(params[:from_date].strftime('%Y-%m-%d 12:00:00'))
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.parse(params[:to_date].strftime('%Y-%m-%d 12:59:59'))
    @line_items = Supplies::LineItem.filter_with(:from_date => @from_date, :to_date => @to_date).order(date: :desc).all
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = OrderLineItemsPdf.new(@line_items, @inventory_id, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Orders.pdf"
      end
    end
  end

  def projects
    @inventory_id = params[:inventory_id].to_i if params[:inventory_id].present?
    @customer_id = params[:customer_id] if params[:customer_id].present?
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_month
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_month
    @line_items = Supplies::LineItem.filter_with(:from_date => @from_date, :to_date => @to_date).order(date: :desc).all
    @orders = Supplies::Order.filter_with(:customer_id => @customer_id, :from_date => @from_date, :to_date => @to_date).where(:customer_type => "Project").order(date_issued: :desc).all.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = ProjectLineItemsPdf.new(@line_items, @inventory_id, @customer_id, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Orders.pdf"
      end
    end
  end
  
  def contractors
    @inventory_id = params[:inventory_id] if params[:inventory_id].present?
    @customer_id = params[:customer_id] if params[:customer_id].present?
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_month
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_month
    @line_items = Supplies::LineItem.filter_with(:from_date => @from_date, :to_date => @to_date).order(date: :desc).all
    @orders = Supplies::Order.filter_with(:customer_id => @customer_id, :from_date => @from_date, :to_date => @to_date).where(:customer_type => "Contractor").order(date_issued: :desc).all.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = ContractorLineItemsPdf.new(@line_items, @inventory_id, @customer_id, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Orders.pdf"
      end
    end
  end

  def equipment
    @inventory_id = params[:inventory_id] if params[:inventory_id].present?
    @customer_id = params[:customer_id] if params[:customer_id].present?
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_month
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_month
    @line_items = Supplies::LineItem.filter_with(:from_date => @from_date, :to_date => @to_date).order(date: :desc).all
    @orders = Supplies::Order.filter_with(:customer_id => @customer_id, :from_date => @from_date, :to_date => @to_date).where(:customer_type => "Equipment").order(date_issued: :desc).all.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = EquipmentLineItemsPdf.new(@line_items, @inventory_id, @customer_id, @from_date, @to_date, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Orders.pdf"
      end
    end
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

  def destroy
    @order = Supplies::Order.find(params[:id])
    if @order.line_items.destroy_all && @order.destroy
      redirect_to orders_url, notice: 'Order successfully deleted.'
    end
  end

  def show
    @order = Supplies::Order.find(params[:id])
    @line_items = @order.line_items.order(date: :desc).page(params[:page]).per(30)
    authorize @order
  end

  private
  def order_params
    params.require(:supplies_order).permit(:date_issued, :project_id, :purpose, :customer_id, :customer_type, :payment_status,
      entry_attributes: [:description, :reference_number, :entriable_id, :entriable_type, :type, :date, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account]])
  end
end
