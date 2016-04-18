class WorkDetails::EquipmentCostsController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @equipment_cost = @work_detail.equipment_costs.build
  end

  def create
     @work_detail = WorkDetail.find(params[:work_detail_id])
    @equipment_cost = @work_detail.equipment_costs.create(equipment_schedule_params)
    if @equipment_cost.save
      redirect_to @work_detail, notice: "Equipment Schedule saved successfully."
    else
      render :new
    end
  end

  private
  def equipment_schedule_params
    params.require(:equipment_schedule).permit(:equipment_id, :start_date, :end_date, :number_of_hours, :rate, :total_cost )
  end
end
