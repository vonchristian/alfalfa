class Projects::EquipmentCostsController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @equipment_cost = @work_detail.equipment_costs.build
  end

  def create
     @work_detail = WorkDetail.find(params[:work_detail_id])
    @equipment_cost = @work_detail.equipment_costs.create(equipment_cost_params)
    if @equipment_cost.save
      redirect_to project_work_detail_path(@work_detail.project, @work_detail), notice: "Equipment cost added successfully."
    else
      render :new
    end
  end

  private
  def equipment_cost_params
    params.require(:equipment_cost).permit(:equipment, :number_of_equipment, :number_of_days, :daily_rate, :total_cost)
  end
end
