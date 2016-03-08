class WorkDetails::EquipmentMaintenancesController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @maintenance = @work_detail.equipment_maintenances.build 
  end
end
