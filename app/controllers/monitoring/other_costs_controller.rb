module Monitoring
  class OtherCostsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @other_costs = @project.other_costs
      respond_to do |format|
        format.html
        format.pdf do
          pdf = otherCostsPdf.new(@project, @other_costs, view_context)
                send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "other Cost.pdf"
        end
      end
    end

    def new
      @project = Project.find(params[:project_id])
      @other_cost = @project.other_costs.build
    end

    def create
      @project = Project.find(params[:project_id])
      @other_cost = @project.other_costs.create(other_cost_params)
      # if @other_cost.save
      #   redirect_to monitoring_project_url(@project), notice: "other Cost saved successfully."
      # else
      #   render :new
      # end
    end

    private
    def other_cost_params
      params.require(:direct_costs_other_cost).permit(:type,:description, :quantity, :unit, :costable_id, :costable_type, :unit_cost, :total_cost, :date)
    end
  end
  end
