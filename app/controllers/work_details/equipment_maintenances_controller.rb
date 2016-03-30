class WorkDetails::EquipmentMaintenancesController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @maintenance = @work_detail.equipment_maintenances.build 
  end

  def create
  	@work_detail = WorkDetail.find(params[:work_detail_id])
    @maintenance = @work_detail.equipment_maintenances.create(maintenance_params)
    if @maintenance.save
    	redirect_to @work_detail, notice: 'Equipment Maintenance saved succesfully.'
    else
    	render :new
    end
  end

  private
  def maintenance_params
  	params.require(:maintenance).permit(:equipment_id, :date, :description, :quantity, :unit, :amount, :remarks, :employee_id)
  end
end
