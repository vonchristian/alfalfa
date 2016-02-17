class Projects::ItemBudgetsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @item_budget = @project.item_budgets.build
  end

  def create
    @project = Project.find(params[:project_id])
    @item_budget = @project.item_budgets.create(item_budget_params)
    if @item_budget.save
      redirect_to @project, notice: "Budget"
    else
      render :new
    end
  end
  private
  def item_budget_params
    params.require(:item_budget).permit(:item_code, :item_description, :unit_price, :amount, :unit, :quantity)
  end
  end
