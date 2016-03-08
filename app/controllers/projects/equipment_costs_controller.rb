class Projects::EquipmentCostsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @equipment_cost = @project.equipment_costs.build
  end

  def create
    @project = Project.find(params[:project_id])
    @equipment_cost = @project.equipment_costs.create(equipment_cost_params)
    if @equipment_cost.save
      redirect_to project_path(@project), notice: "Equipment cost added successfully."
    else
      render :new
    end
  end

  private
  def equipment_cost_params
    params.require(:equipment_cost).permit(:equipment, :number_of_equipment, :number_of_days, :daily_rate, :total_cost)
  end
end
