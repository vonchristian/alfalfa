module Monitoring
  class ContractsController < ApplicationController
    layout "monitoring"
    def new
      @project = Project.find(params[:project_id])
      @contract = @project.contracts.build
    end

    def create
      @project = Project.find(params[:project_id])
      @contract = @project.contracts.create(contract_params)
      authorize @contract
      if @contract.save
        @contract.create_activity :create, owner: current_user, trackable: @project
        redirect_to monitoring_project_url(@project), notice: "Contract saved successfully."
      else
        render :new
      end
    end

    def show
      @contract = Contract.find(params[:id])
    end

    def edit
      @contract = Contract.find(params[:id])
      @project = @contract.project
    end
    def update
      @contract = Contract.find(params[:id])
      @project = @contract.project
      @contract.update(contract_params)
      if @contract.save
        redirect_to monitoring_contract_url(@contract), notice: "Contract updated successfully."
      else
        render :edit
      end
    end

    private
    def contract_params
      params.require(:contract).permit(:contractor_id, :amount_subcontracted)
    end
  end
end
