class Supplies::InventoriesController  < ApplicationController
  layout 'supplies'
  def index
    @inventories = Inventory.order(:name)
  end
end
