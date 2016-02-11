class ContractsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @contract = @project.contracts.build
  end

  def create
    @project = Project.find(params[:project_id])
    @contract = @project.contracts.build(contract_params)
    if @contract.save
      @contract.create_activity :create, owner: current_user, recipient: @project
      
      redirect_to @project, notice: "successfully"
    else
      render :new
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:contractor_id)
  end
end
