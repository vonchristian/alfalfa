class WorkDetails::EquipmentFuelCostsController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @fuel_expense = @work_detail.equipment_fuel_costs.build
  end

  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @fuel_expense = @work_detail.equipment_fuel_costs.create(fuel_expense_params)
    if @fuel_expense.save
      redirect_to @work_detail, notice: "Equipment Fuel Cost saved successfully."
    else
      render :new
    end
  end

  private
  def fuel_expense_params
    params.require(:issued_inventory).permit( :inventory_id, :quantity, :total_cost, :date_issued)
  end


end
