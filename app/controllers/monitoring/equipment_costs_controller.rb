module Monitoring
  class EquipmentCostsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @equipment_costs = @project.equipment_costs
      respond_to do |format|
        format.html
        format.pdf do
          pdf = SubContractCostsPdf.new(@project, @equipment_costs, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "equipment Cost.pdf"
        end
      end
    end

    def new
      @project = Project.find(params[:project_id])
      @equipment_cost = @project.equipment_costs.build
    end

    def create
      @project = Project.find(params[:project_id])
      @equipment_cost = @project.equipment_costs.create(equipment_cost_params)
      if @equipment_cost.save
        redirect_to monitoring_project_equipment_costs_url(@project), notice: "Equipment cost saved successfully."
      else
        render :new
      end
    end

    private
    def equipment_cost_params
      params.require(:direct_costs_equipment).permit(:type, :description, :quantity, :unit, :costable_id, :costable_type, :unit_cost, :total_cost, :date)
    end
  end
end
