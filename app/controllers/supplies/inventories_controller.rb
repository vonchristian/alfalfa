class Supplies::InventoriesController  < ApplicationController
  layout 'supplies'
  def index
    @inventories = Inventory.all.order('created_at DESC').page(params[:page]).per(10)
  end
end
