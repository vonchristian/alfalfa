class EquipmentController < ApplicationController
  def index
    @equipments = Equipment.all
  end
  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.create(equipment_params)
    if @equipment.save
      redirect_to @equipment, notice: "Equipment saved successfully."
    else
      render :new
    end
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  private
  def equipment_params
    params.require(:equipment).permit(:make, :model, :plate_number, :acquisition_cost)
  end
end
