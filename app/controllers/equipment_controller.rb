class EquipmentController < ApplicationController
  def index
    @equipments = Equipment.all
  end
  def new
    @equipments = Equipment.all
    @equipment = Equipment.new
    authorize @equipment
  end

  def create
    @equipment = Equipment.create(equipment_params)
    authorize @equipment
    if @equipment.save
      redirect_to equipment_index_path, notice: "Equipment saved successfully."
    else
      render :new
    end
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:id])
    authorize @equipment
    if @equipment.update
      redirect_to equipments_path, notice: 'Equipment updated successfully.'
    else
      render :edit
    end
  end

  private
  def equipment_params
    params.require(:equipment).permit(:make, :model, :plate_number, :acquisition_cost)
  end
end
