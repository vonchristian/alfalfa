class SuppliesController < ApplicationController

  layout 'supplies'

  def index
    if params[:name].present?
      @inventories = Supplies::Inventory.search_by_name(params[:name]).order(:name)
    else
      @inventories = Supplies::Inventory.all.order(:name).page(params[:page]).per(30)
    end
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
    @order = Supplies::Order.new
  end

  def cement_category
    item_category_id = ItemCategory.find_by(:name => 'Cement').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def fuel_category
    item_category_id = ItemCategory.find_by(:name => 'Fuel').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def explosive_category
    item_category_id = ItemCategory.find_by(:name => 'Explosive').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def aggregate_category
    item_category_id = ItemCategory.find_by(:name => 'Aggregate').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def tire_category
    item_category_id = ItemCategory.find_by(:name => 'Tire').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def chb_category
    item_category_id = ItemCategory.find_by(:name => 'CHB').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def rsb_category
    item_category_id = ItemCategory.find_by(:name => 'RSB').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def rcpc_category
    item_category_id = ItemCategory.find_by(:name => 'RCPC').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def cwn_category
    item_category_id = ItemCategory.find_by(:name => 'CWN').id
    @inventories = Supplies::Inventory.where(:item_category_id => item_category_id).all.order(:name)
    authorize :supply, :show?
    @cart = current_cart
    @line_item = Supplies::LineItem.new
  end

  def show
  end
end
