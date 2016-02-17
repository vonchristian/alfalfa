class CostCode::DivisionsController < ApplicationController
  def index
    @divisions = CostCode::Division.all
  end

  def new
    @division = CostCode::Division.new
  end

  def create
    @division = CostCode::Division.create(division_params)
    if @division.save
      redirect_to @division,  notice: "Division saved successfully."
    else
      render :new
    end
  end

  def show
    @division = CostCode::Division.find(params[:id])
  end

  private
  def division_params
    params.require(:cost_code_division).permit(:name)
  end
end
