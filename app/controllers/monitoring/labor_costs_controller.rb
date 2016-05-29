module Monitoring
  class LaborCostsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @labor_costs = @project.labor_costs
      respond_to do |format|
        format.html
        format.pdf do
          pdf = LaborCostsPdf.new(@project, @labor_costs, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Labor Cost.pdf"
        end
      end
    end
    
    def new
      @project = Project.find(params[:project_id])
      @labor_cost = @project.labor_costs.build
    end

    def create
      @project = Project.find(params[:project_id])
      @labor_cost = @project.labor_costs.create(labor_cost_params)
      if @labor_cost.save
        redirect_to monitoring_project_url(@project), notice: "Labor Cost saved successfully."
      else
        render :new
      end
    end

    private
    def labor_cost_params
      params.require(:monitoring_project_labor_cost).permit(:type, :quantity, :unit, :description, :unit_cost, :total_cost, :date)
    end
  end
end