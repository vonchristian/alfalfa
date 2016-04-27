class Equipment::EquipmentSchedulesController < ApplicationController

  def new
    @equipment = Equipment.find(params[:equipment_id])
    @equipment_schedule = @equipment.equipment_schedules.build
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @equipment_schedule = @equipment.equipment_schedules.create(equipment_schedule_params)
    if @equipment_schedule.save
      redirect_to @equipment, notice: "Equipment Schedule saved successfully."
    else
      render :new
    end
  end

  private
  def equipment_schedule_params
    params.require(:equipment_schedule).permit(:project_id, :employee_id)
  end
end
