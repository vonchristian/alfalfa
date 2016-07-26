class Equipment::LineItemsController < ApplicationController
  layout 'supplies'
  def index
    @equipment = Equipment.find(params[:equipment_id])
    @inventory = Supplies::Inventory.find_by(:name => 'Diesel')
    @line_items = @equipment.line_items.where(:inventory_id => @inventory.id).order(date: :desc).all
    # respond_to do |format|
    #   format.pdf do 
    #     pdf = EquipmentLineItemsPdf.new(@equipment, @line_items, view_context)
    #           send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "FuelAndLubrication.pdf"
    #   end
    # end
  end

  def scope_to_date
    @equipment = Equipment.find(params[:equipment_id])
    @inventory = Supplies::Inventory.find_by(:name => 'Diesel')
    @line_items = @equipment.line_items.where(:inventory_id => @inventory.id).order(date: :desc).all
    respond_to do |format|
      format.pdf do 
        pdf = EquipmentLineItemsPdf.new(@equipment, @line_items, view_context)
              send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "FuelAndLubrication.pdf"
      end
    end
  end

end
