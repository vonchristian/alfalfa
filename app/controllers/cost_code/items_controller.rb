class CostCode::ItemsController < ApplicationController


  def new
    @division = CostCode::Division.find(params[:division_id])
    @item = @division.items.build
  end

  def create
   @division = CostCode::Division.find(params[:division_id])
    @item = @division.items.create(item_params)
    if @item.save
      redirect_to @division,  notice: "item saved successfully."
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:cost_code_item).permit(:description, :code)
  end
end
