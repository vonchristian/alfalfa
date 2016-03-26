class ContractsController < ApplicationController
  def index
    @contracts = Contract.all
  end
  def new
    @project = Project.find(params[:project_id])
    @contract = @project.contracts.build
    authorize @contract
  end

  def create
    @project = Project.find(params[:project_id])
    @contract = @project.contracts.build(contract_params)
    authorize @contract
    if @contract.save
      @contract.create_activity :create, owner: current_user, trackable: @project
      redirect_to new_project_contract_url(@project), notice: "Contractor added successfully."
    else
      render :new
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:contractor_id, :amount_subcontracted)
  end
end
