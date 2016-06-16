module Monitoring
  class SubContractCostsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @sub_contract_costs = @project.sub_contract_costs
      respond_to do |format|
        format.html
        format.pdf do
          pdf = SubContractCostsPdf.new(@project, @sub_contract_costs, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "sub_contract Cost.pdf"
        end
      end
    end

    def new
      @project = Project.find(params[:project_id])
      @sub_contract_cost = @project.sub_contract_costs.build
    end

    def create
      @project = Project.find(params[:project_id])
      @sub_contract_cost = @project.sub_contract_costs.create(sub_contract_cost_params)
      if @sub_contract_cost.save
        redirect_to monitoring_project_sub_contract_costs_url(@project), notice: "Sub contract cost saved successfully."
      else
        render :new
      end
    end

    private
    def sub_contract_cost_params
      params.require(:direct_costs_sub_contract).permit(:type, :description, :quantity, :unit, :costable_id, :costable_type, :unit_cost, :total_cost, :date)
    end
  end
end
