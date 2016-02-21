class ContractsController < ApplicationController
  def index
    @contracts = Contract.all
  end
  def new
    @project = Project.find(params[:project_id])
    @contract = @project.contracts.build
  end

  def create
    @project = Project.find(params[:project_id])
    @contract = @project.contracts.build(contract_params)
    if @contract.save
      @contract.create_activity :create, owner: current_user, trackable: @project

      redirect_to @project, notice: "Contractor added successfully to project."
    else
      render :new
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:contractor_id, :amount)
  end
end
