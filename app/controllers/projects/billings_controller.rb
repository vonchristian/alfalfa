class Projects::BillingsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @billing = @project.billings.build
  end

  def create
    @project = Project.find(params[:project_id])
    @billing = @project.billings.build(billing_params)
    if @billing.save
      redirect_to @project, notice: "Billing recorded successfully"
    else
      render :new
    end
  end

  private
  def billing_params
    params.require(:billing).permit(:contractor_id, :inventory_id, :quantity)
  end
end
