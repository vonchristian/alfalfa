class Equipment::EquipmentSchedulesController < ApplicationController
  layout 'supplies'
  def new
    @equipment = Equipment.find(params[:equipment_id])
    if @equipment.inactive?
      redirect_to @equipment, alert: 'Cannot create schedule. Equipment is Inactive!'
    else
      @equipment_schedule = @equipment.equipment_schedules.build
    end
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
    params.require(:equipment_schedule).permit(:project_id, :employee_id, :purpose, :start_date, :end_date)
  end
end
