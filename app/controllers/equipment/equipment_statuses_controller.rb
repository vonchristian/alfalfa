class Equipment::EquipmentStatusesController < ApplicationController

  def new
    @equipment = Equipment.find(params[:equipment_id])
    @equipment_status = @equipment.build_equipment_status
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @equipment_status = @equipment.create_equipment_status(equipment_status_params)
    if @equipment_status.save
      redirect_to @equipment, notice: "Equipment status saved successfully."
    else
      render :new
    end
  end

  def edit
    @equipment = Equipment.find(params[:equipment_id])
    @equipment_status = EquipmentStatus.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:equipment_id])
    @equipment_status = EquipmentStatus.find(params[:id])
    if @equipment_status.update(equipment_status_params)
      redirect_to @equipment, notice: 'Equipment status updated successfully.'
    else
      render :edit
    end
  end

  private
  def equipment_status_params
    params.require(:equipment_status).permit(:status, :description)
  end
end
