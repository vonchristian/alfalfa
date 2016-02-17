class Projects::LaborCostsController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @labor_cost = @work_detail.labor_costs.build
  end

  def create
     @work_detail = WorkDetail.find(params[:work_detail_id])
    @labor_cost = @work_detail.labor_costs.create(labor_cost_params)
    if @labor_cost.save
      redirect_to project_work_detail_path(@work_detail.project, @work_detail), notice: "Labor cost added successfully."
    else
      render :new
    end
  end

  private
  def labor_cost_params
    params.require(:labor_cost).permit(:personnel, :number_of_personnel, :number_of_days, :daily_rate, :total_cost)
  end
end
