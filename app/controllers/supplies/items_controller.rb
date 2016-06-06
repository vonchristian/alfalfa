module Supplies
  class ItemsController < ApplicationController
    layout "supplies"
    def new
      @equipment = Equipment.find(params[:equipment_id])
      @item = @equipment.items.build
    end

    def create
      @equipment = Equipment.find(params[:equipment_id])
      @item = @equipment.items.create(item_params)
      if @item.save
        redirect_to supplies_equipment_path(@equipment), notice: "Item saved successfully."
      else
        render :new
      end
    end

    private
    def item_params
      params.require(:item).permit(:date, :description, :unit_cost, :total_cost, :quantity)
    end
  end
end
